// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super(GpsInitial()) {
    on<GpsGetLocation>(
      (event, emit) async {
        print("ddddddddddd");
        try {
          // Memeriksa status izin lokasi
          PermissionStatus status = await Permission.location.request();
          if (status.isDenied) {
            // Jika izin ditolak, keluar dari aplikasi
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          } else if (status.isPermanentlyDenied) {
            openAppSettings();
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
            Position position = await Geolocator.getPositionStream(
                    locationSettings: locationSettings)
                .first;

            print(position);
            emit(GpsIsLoaded(data: position));
          }
        } catch (e) {
          // print(e);
          emit(GpsIsFailure('$e'));
        }
      },
    );
  }
}
