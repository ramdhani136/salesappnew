// ignore_for_file: non_constant_identifier_names

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

class LocationGps {
  Future<Position?> CheckLocation() async {
    try {
      // Memeriksa status izin lokasi
      PermissionStatus status = await Permission.location.request();
      if (status.isDenied) {
        // Jika izin ditolak, keluar dari aplikasi
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return null;
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      } else if (status.isGranted) {
        // Mendapatkan posisi saat ini
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        return position;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> chekcAdress() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];
      String address = '${place.name}, ${place.locality}, ${place.country}';

      // print('Address: $address');
      return address;
    } catch (e) {
      // print('Error: $e');
      rethrow;
    }
  }
}
