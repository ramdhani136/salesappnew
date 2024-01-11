// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  Position? pos;
  StreamSubscription<Position>? _positionStreamSubscription;
  GpsBloc() : super(GpsInitial()) {
    on<GpsSetLocation>((event, emit) {
      emit(GpsIsLoaded(event.position));
    });
    on<GpsGetLocation>(
      (event, emit) async {
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
              add(GpsSetLocation(position));
            });
          }
        } catch (e) {
          // print(e);
          emit(GpsIsFailure('$e'));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _positionStreamSubscription?.cancel();
    return super.close();
  }
}
