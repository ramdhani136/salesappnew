// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/location/location_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';

class VisitCheckOut extends StatelessWidget {
  VisitBloc visitBloc;
  LatLng checkInCordinate;
  late String address;
  late LatLng cordinate;
  VisitCheckOut(
      {super.key, required this.checkInCordinate, required this.visitBloc});

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> controller0 =
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
                          // myLocationEnabled: true,
                          trafficEnabled: true,
                          compassEnabled: true,
                          // myLocationButtonEnabled: true,
                          markers: {
                            Marker(
                              onTap: () {},
                              markerId: const MarkerId('me'),
                              infoWindow: const InfoWindow(
                                title: 'Your Location!',
                              ),
                              icon: state is LocationLoaded
                                  ? state.IconEtmMaps!
                                  : BitmapDescriptor.defaultMarker,
                              position: LatLng(
                                loc.cordinate!.latitude,
                                loc.cordinate!.longitude,
                              ),
                            ),
                            Marker(
                              onTap: () {},
                              markerId: const MarkerId('CheckIn Location'),
                              infoWindow: const InfoWindow(
                                title: 'CheckIn Location',
                              ),
                              visible: true,
                              icon: state is LocationLoaded
                                  ? state.IconCustomerMaps!
                                  : BitmapDescriptor.defaultMarker,
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
                              zoom: 30.151926040649414),
                          onMapCreated: (GoogleMapController controller) {
                            controller0.complete(controller);
                          },
                          circles: <Circle>{
                            Circle(
                              circleId: const CircleId('myLocation'),
                              center: checkInCordinate,
                              radius: state is LocationLoaded
                                  ? state.distanceCheckOut!.toDouble()
                                  : 0,
                              strokeWidth: 2,
                              strokeColor: Colors.amber,
                              fillColor: Colors.amber.withOpacity(0.2),
                            ),
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6212A),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 195, 16, 25),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final GoogleMapController controller =
                                      await controller0.future;
                                  controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                          target: LatLng(
                                            loc.cordinate!.latitude,
                                            loc.cordinate!.longitude,
                                          ),
                                          bearing: 192.8334901395799,
                                          tilt: 59.440717697143555,
                                          zoom: 30.151926040649414),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6212A),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 195, 16, 25),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.gps_fixed,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      loc.address ?? "Failed to get location info!",
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
