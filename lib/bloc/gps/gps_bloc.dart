// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, unused_import

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/utils/location_gps.dart';
import 'package:salesappnew/utils/tools.dart';
part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription<Position>? _positionStreamSubscription;

  GpsBloc() : super(GpsInitial()) {
    on<GpsSetLocation>((event, emit) {
      emit(GpsIsLoaded(event.position));
    });
    on<GpsSetError>((event, emit) {
      emit(GpsIsFailure(event.msg));
    });
    on<GpsSetCheckInOut>(
      (event, emit) => _GpsSetCheckInOut(event, emit),
    );
    on<GpsGetLocation>(
      (event, emit) => _GpsGetLocation(event, emit),
    );
  }

  Future<void> _GpsGetLocation(
    GpsGetLocation event,
    Emitter<GpsState> emit,
  ) async {
    try {
      // Memeriksa status izin lokasi
      PermissionStatus status = await Permission.location.request();
      if (status.isDenied) {
        // Jika izin ditolak, keluar dari aplikasi
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
      } else if (status.isGranted) {
        emit(GpsIsLoading());
        final Uint8List markerIcon =
            await Tools().getBytesFromAsset('assets/icons/etm.png', 130);
        final Uint8List customerIcon = await Tools()
            .getBytesFromAsset('assets/icons/pincustomermaps.png', 130);
        // End

        Map<String, dynamic> config = {};

        if (event.checkInOut != null) {
          config = await FetchData(data: Data.config).FINDALL();
        }

        LocationSettings locationSettings = event.distanceFilter != null
            ? LocationSettings(
                accuracy: LocationAccuracy.high,
                distanceFilter: event.distanceFilter!,
              )
            : const LocationSettings(
                accuracy: LocationAccuracy.high,
              );
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = Geolocator.getPositionStream(
          locationSettings: locationSettings,
        ).listen((Position position) {
          if (position.isMocked) {
            add(GpsSetError("Fake location detected!"));
          } else {
            if (event.checkInOut != null) {
              add(
                GpsSetCheckInOut(
                  config: config,
                  customer: event.checkInOut?.customer != null
                      ? event.checkInOut?.customer!
                      : "",
                  customerIcon: customerIcon,
                  markerIcon: markerIcon,
                  position: position,
                ),
              );
            } else {
              add(GpsSetLocation(position));
            }
          }
        });
      }
    } catch (e) {
      emit(GpsIsFailure('$e'));
    }
  }

  Future<void> _GpsSetCheckInOut(
    GpsSetCheckInOut event,
    Emitter<GpsState> emit,
  ) async {
    try {
      bool IsInsite = false;

      if (event.customer != "") {
        Map<String, dynamic> IsInsiteCustomer =
            await FetchData(data: Data.customer).FINDALL(
                nearby:
                    "&nearby=[${event.position.latitude},${event.position.longitude},${event.config['data']['visit']['checkInDistance']}]",
                filters: [
              [
                "_id",
                "=",
                event.customer!,
              ]
            ]);

        if (IsInsiteCustomer['data'] != null) {
          IsInsite = true;
        } else {
          IsInsite = false;
        }
      }

      String address = await LocationGps().chekcAdress(event.position);

      emit(
        GpsCheckInOutIsLoaded(
          IconEtmMaps: BitmapDescriptor.fromBytes(event.markerIcon),
          IconCustomerMaps: BitmapDescriptor.fromBytes(event.customerIcon),
          distanceCheckIn: event.config['data']['visit']['checkInDistance'],
          distanceCheckOut: event.config['data']['visit']['checkOutDistance'],
          insite: IsInsite,
          position: event.position,
          address: address,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _positionStreamSubscription?.cancel();
    return super.close();
  }

  void stopGps() {
    _positionStreamSubscription?.cancel();
  }
}
