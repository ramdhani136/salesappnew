// ignore_for_file: non_constant_identifier_names

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class LocationGps {
  Future<void> CheckLocation() async {
    try {
      // Memeriksa status izin lokasi
      PermissionStatus status = await Permission.location.request();
      if (status.isDenied) {
        // Jika izin ditolak, keluar dari aplikasi
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return;
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      } else if (status.isGranted) {
        // Mendapatkan posisi saat ini
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        print(position);
      }
    } catch (e) {
      rethrow;
    }
  }
}
