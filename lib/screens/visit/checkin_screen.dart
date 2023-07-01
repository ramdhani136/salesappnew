// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesappnew/bloc/customer/customer_bloc.dart';
import 'package:salesappnew/bloc/location/location_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckInScreen extends StatefulWidget {
  String customerId;
  CheckInScreen({
    super.key,
    required this.customerId,
  });

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final LocationBloc locationbloc = LocationBloc();
  TextEditingController nameC = TextEditingController();

  @override
  void dispose() {
    locationbloc.close(); // Menutup Bloc saat halaman ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _panelC = PanelController();
    VisitBloc visitBloc = VisitBloc();

    Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              BlocBuilder<LocationBloc, LocationState>(
                bloc: locationbloc,
                builder: (context, state) {
                  if (state is LocationInitial) {
                    locationbloc.add(GetLocationGps());
                  }
                  if (state is LocationLoading) {
                    return const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      ),
                    );
                  }

                  if (state is LocationFailure) {
                    // _controller = Completer<GoogleMapController>();
                    locationbloc.add(GetLocationGps(notLoading: true));
                  }

                  if (locationbloc.cordinate != null) {
                    locationbloc.add(
                      GetRealtimeGps(
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return Maps(locationbloc, _controller, state);
                  }

                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    ),
                  );
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
                          color: Color(0xFFE6212A),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Color.fromARGB(255, 195, 16, 25),
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
                            await _controller.future;
                        controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                                target: LatLng(
                                  locationbloc.cordinate!.latitude,
                                  locationbloc.cordinate!.longitude,
                                ),
                                bearing: 192.8334901395799,
                                tilt: 59.440717697143555,
                                zoom: 18.151926040649414),
                          ),
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFE6212A),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Color.fromARGB(255, 195, 16, 25),
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
        BlocBuilder(
            bloc: visitBloc,
            builder: (context, stateVisit) {
              CustomerBloc customerBloc = CustomerBloc()
                ..add(
                  ShowCustomer(
                    widget.customerId,
                  ),
                );
              return SlidingUpPanel(
                defaultPanelState: PanelState.OPEN,
                controller: _panelC,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                parallaxEnabled: true,
                maxHeight: 430,
                minHeight: 30,
                panel: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _panelC.isPanelOpen
                                ? _panelC.close()
                                : _panelC.open();
                          },
                          child: Container(
                            width: 30,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  child: ListView(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 236, 231, 231),
                                            width: 1,
                                          ),
                                        ),
                                        child: BlocBuilder<LocationBloc,
                                            LocationState>(
                                          bloc: locationbloc,
                                          builder: (context, stateLoc) {
                                            if (stateLoc is LocationLoading) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 10,
                                                  height: 10,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 3,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                              );
                                            }

                                            return Row(
                                              children: [
                                                Icon(
                                                  Icons.gps_fixed_sharp,
                                                  size: 16,
                                                  color: Colors.grey[800],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Text(
                                                      "${locationbloc.address}",
                                                      style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "VST202306XXXX",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            BlocBuilder<CustomerBloc,
                                                CustomerState>(
                                              bloc: customerBloc,
                                              builder: (
                                                context,
                                                stateCustomer,
                                              ) {
                                                if (stateCustomer
                                                    is CustomerIsLoading) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }

                                                if (stateCustomer
                                                    is CustomerShowLoaded) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${stateCustomer.data.name}",
                                                            style: TextStyle(
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.edit,
                                                              size: 20,
                                                              color: Colors
                                                                  .amber[600],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Visibility(
                                                        visible: stateCustomer
                                                                    .data
                                                                    .address !=
                                                                null ||
                                                            stateCustomer.data
                                                                    .address !=
                                                                "",
                                                        child: Text(
                                                          "${stateCustomer.data.address}",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors
                                                                .grey[700],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 8,
                                                          vertical: 2,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: const Color.fromARGB(
                                                          //     255, 255, 198, 27),
                                                          color:
                                                              Colors.red[400],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            // color: const Color.fromARGB(
                                                            //     255, 225, 170, 5),
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                218,
                                                                50,
                                                                38),
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          // "Insite",
                                                          "Outsite",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            // color: Color.fromARGB(
                                                            //     255, 156, 118, 3),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  );
                                                }
                                                return Container();
                                              },
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15),
                                                    width: Get.width * 0.9,
                                                    height: Get.width / 1.85,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 232, 231, 231),
                                                      ),
                                                    ),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.hide_image_outlined,
                                                      color: Color(0xFFE0E0E0),
                                                      size: 100,
                                                    )),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15),
                                                    width: Get.width * 0.9,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                      ),
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () async {},
                                                      icon: const Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.white,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Aksi saat tombol ditekan
                                  },
                                  child: Text(
                                    'Check In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 33, 143, 36),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    ));
  }
}

// ignore: non_constant_identifier_names
GoogleMap Maps(
    LocationBloc loc, Completer<GoogleMapController> _controller, state) {
  LocationLoaded? data;
  if (state is LocationLoaded) {
    data = state;
  }

  return GoogleMap(
    mapType: MapType.normal,
    myLocationEnabled: true,
    trafficEnabled: true,
    compassEnabled: true,
    myLocationButtonEnabled: true,
    markers: {
      Marker(
        onTap: () {},
        markerId: const MarkerId('me'),
        infoWindow: const InfoWindow(
          title: 'Your Location!',
        ),
        icon: data!.IconEtmMaps ?? BitmapDescriptor.defaultMarker,
        position: LatLng(
          loc.cordinate!.latitude,
          loc.cordinate!.longitude,
        ),
      ),
      Marker(
        onTap: () {},
        markerId: const MarkerId('PT. Abadi Baru'),
        infoWindow: const InfoWindow(
          title: 'PT. Abadi Baru',
        ),
        visible: true,
        icon: data!.IconCustomerMaps ?? BitmapDescriptor.defaultMarker,
        position: LatLng(-6.5107604, 106.8638661),
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
      // controller.setMapStyle();
    },
    polygons: {
      Polygon(
        polygonId: const PolygonId('area_1'),
        points: [
          LatLng(-6.5107604, 106.8638661),
          LatLng(-6.5107604, 106.8638661),
          LatLng(-6.5107604, 106.8638661),
        ],
        fillColor: Colors.blue.withOpacity(0.5), // Warna area jangkauan
        strokeColor: Colors.blue, // Warna garis tepi area jangkauan
      ),
    },
    circles: <Circle>{
      Circle(
        circleId: const CircleId('myLocation'),
        center: LatLng(-6.5107604, 106.8638661), // Koordinat lokasi saat ini
        radius: 50, // Jari-jari dalam meter
        strokeWidth: 2,
        strokeColor: Colors.amber,
        fillColor: Colors.amber.withOpacity(0.2),
      ),
    },
  );
}
