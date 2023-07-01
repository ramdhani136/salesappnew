// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/utils/location_gps.dart';
import 'package:http/http.dart' as http;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationGps location = LocationGps();
  String? address;
  Position? cordinate;

  LocationBloc() : super(LocationInitial()) {
    Future<Uint8List> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    }

    Future<Uint8List> getBytesFromUrl(String url, int width) async {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Uint8List imageData = response.bodyBytes;
        ui.Codec codec =
            await ui.instantiateImageCodec(imageData, targetWidth: width);
        ui.FrameInfo fi = await codec.getNextFrame();
        return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
      } else {
        throw Exception('Failed to load image from $url');
      }
    }

    // Future<Uint8List> getBytesFromUrl(String url, int width) async {
    //   http.Response response = await http.get(Uri.parse(url));
    //   if (response.statusCode == 200) {
    //     Uint8List imageData = response.bodyBytes;
    //     ui.Codec codec =
    //         await ui.instantiateImageCodec(imageData, targetWidth: width);
    //     ui.FrameInfo fi = await codec.getNextFrame();

    //     final recorder = ui.PictureRecorder();
    //     final canvas = Canvas(recorder);

    //     final imageSize =
    //         Size(fi.image.width.toDouble(), fi.image.height.toDouble());
    //     final avatarSize = Size(width.toDouble(), width.toDouble());

    //     canvas.drawImageRect(
    //         fi.image,
    //         Rect.fromLTWH(0, 0, imageSize.width, imageSize.height),
    //         Rect.fromLTWH(0, 0, avatarSize.width, avatarSize.height),
    //         Paint());

    //     final picture = recorder.endRecording();
    //     final img = await picture.toImage(
    //         avatarSize.width.toInt(), avatarSize.height.toInt());
    //     final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    //     return byteData!.buffer.asUint8List();
    //   } else {
    //     throw Exception('Failed to load image from $url');
    //   }
    // }

    // Future<Uint8List> getBytesFromUrl(String url, int width) async {
    //   http.Response response = await http.get(Uri.parse(url));
    //   if (response.statusCode == 200) {
    //     Uint8List imageData = response.bodyBytes;
    //     ui.Codec codec =
    //         await ui.instantiateImageCodec(imageData, targetWidth: width);
    //     ui.FrameInfo fi = await codec.getNextFrame();

    //     final recorder = ui.PictureRecorder();
    //     final canvas = Canvas(recorder);

    //     final imageSize =
    //         Size(fi.image.width.toDouble(), fi.image.height.toDouble());
    //     final avatarSize = Size(width.toDouble(), width.toDouble());

    //     canvas.drawImageRect(
    //         fi.image,
    //         Rect.fromLTWH(0, 0, imageSize.width, imageSize.height),
    //         Rect.fromLTWH(0, 0, avatarSize.width, avatarSize.height),
    //         Paint());

    //     final picture = recorder.endRecording();
    //     final img = await picture.toImage(
    //         avatarSize.width.toInt(), avatarSize.height.toInt());
    //     final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    //     return byteData!.buffer.asUint8List();
    //   } else {
    //     throw Exception('Failed to load image from $url');
    //   }
    // }

    on<LocationEvent>((event, emit) async {
      if (event is GetLocationGps) {
        try {
          if (event.loading) {
            emit(LocationLoading());
          }
          cordinate = await location.CheckLocation();
          if (cordinate != null) {
            address = await location.chekcAdress(cordinate!);
            final Uint8List markerIcon =
                // await getBytesFromUrl(
                //     'http://103.56.149.31:5500/images/users/Miana%20Siva.40.05.jpeg',
                //     110);
                await getBytesFromAsset('assets/icons/etm.png', 250);
            final Uint8List customerIcon = await getBytesFromAsset(
                'assets/icons/pincustomermaps.png', 250);

            emit(LocationLoaded(
              IconEtmMaps: BitmapDescriptor.fromBytes(markerIcon),
              IconCustomerMaps: BitmapDescriptor.fromBytes(customerIcon),
            ));
          }
        } catch (e) {
          emit(LocationFailure(e.toString()));
        }
      }
      if (event is GetRealtimeGps) {
        try {
          await Future.delayed(event.duration);
          // emit(LocationLoading());
          cordinate = await location.CheckLocation();
          if (cordinate != null) {
            address = await location.chekcAdress(cordinate!);
            final Uint8List markerIcon =
                await getBytesFromAsset('assets/icons/etm.png', 250);
            // final Uint8List markerIcon = await getBytesFromUrl(
            //     'http://103.56.149.31:5500/images/users/Miana%20Siva.40.05.jpeg',
            //     110);
            final Uint8List customerIcon = await getBytesFromAsset(
                'assets/icons/pincustomermaps.png', 250);

            emit(LocationLoaded(
              IconEtmMaps: BitmapDescriptor.fromBytes(markerIcon),
              IconCustomerMaps: BitmapDescriptor.fromBytes(customerIcon),
            ));
          }
        } catch (e) {
          emit(LocationFailure(e.toString()));
        }
      }
    });
  }
}
