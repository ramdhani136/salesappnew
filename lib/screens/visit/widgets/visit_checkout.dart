// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/location/location_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/utils/location_gps.dart';

class VisitCheckOut extends StatelessWidget {
  VisitBloc visitBloc;
  LatLng checkInCordinate;
  late String address;
  late LatLng cordinate;
  VisitCheckOut(
      {super.key, required this.checkInCordinate, required this.visitBloc});

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    return BlocProvider(
      create: (context) => LocationBloc()..add(GetLocationGps()),
      child: Scaffold(
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            LocationBloc loc = BlocProvider.of<LocationBloc>(context);

            if (state is LocationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LocationFailure) {
              loc.add(GetLocationGps(notLoading: true));
            }

            if (loc.cordinate != null) {
              visitBloc.checkOutAddress = loc.address;
              visitBloc.checkOutCordinates = loc.cordinate;

              loc.add(
                GetRealtimeGps(
                  duration: const Duration(seconds: 2),
                ),
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          trafficEnabled: true,
                          compassEnabled: true,
                          myLocationButtonEnabled: true,
                          markers: {
                            Marker(
                              onTap: () {},
                              markerId: const MarkerId('CheckIn Location'),
                              infoWindow: const InfoWindow(
                                title: 'CheckIn Location',
                              ),
                              visible: true,
                              icon: BitmapDescriptor.defaultMarker,
                              position: checkInCordinate,
                            )
                          },
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                loc.cordinate!.latitude,
                                loc.cordinate!.longitude,
                              ),
                              bearing: 192.8334901395799,
                              tilt: 59.440717697143555,
                              zoom: 18.151926040649414),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          circles: <Circle>{
                            Circle(
                              circleId: const CircleId('myLocation'),
                              center:
                                  checkInCordinate, // Koordinat lokasi saat ini
                              radius: 50, // Jari-jari dalam meter
                              strokeWidth: 2,
                              strokeColor: Colors.amber,
                              fillColor: Colors.amber.withOpacity(0.2),
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${loc.address ?? "Failed to get location info!"}",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
