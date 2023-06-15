import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesappnew/bloc/location/location_bloc.dart';

class CheckInScreen extends StatelessWidget {
  CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationInitial) {
            context.read<LocationBloc>().add(GetLocationGps());
          }
          if (state is LocationLoading) {
            return const Center(
              child: CircularProgressIndicator(
                  // strokeWidth: 2,
                  // valueColor: AlwaysStoppedAnimation<Color>(
                  //     Color.fromARGB(255, 236, 181, 16)),
                  ),
            );
          }

          if (state is LocationAddress) {
            return GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                  onTap: () {},
                  markerId: const MarkerId('me'),
                  infoWindow: const InfoWindow(
                    title: 'Your Location!',
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(
                    state.cordinate!.latitude,
                    state.cordinate!.longitude,
                  ),
                ),
                Marker(
                  onTap: () {},
                  markerId: const MarkerId('PT. Abadi Baru'),
                  infoWindow: const InfoWindow(
                    title: 'PT. Abadi Baru',
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(-6.5107604, 106.8638661),
                )
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  state.cordinate!.latitude,
                  state.cordinate!.longitude,
                ),
                zoom: 16.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polygons: {
                Polygon(
                  polygonId: PolygonId('area_1'),
                  points: [
                    LatLng(
                      state.cordinate!.latitude,
                      state.cordinate!.longitude,
                    ),
                    LatLng(
                      state.cordinate!.latitude,
                      state.cordinate!.longitude,
                    ),
                    LatLng(
                      state.cordinate!.latitude,
                      state.cordinate!.longitude,
                    ),
                  ],
                  fillColor:
                      Colors.blue.withOpacity(0.5), // Warna area jangkauan
                  strokeColor: Colors.blue, // Warna garis tepi area jangkauan
                ),
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
