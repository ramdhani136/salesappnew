import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesappnew/bloc/location/location_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final LocationBloc locationbloc = LocationBloc();

  @override
  void dispose() {
    locationbloc.close(); // Menutup Bloc saat halaman ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _panelC = PanelController();

    Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();
    final LocationBloc loc = LocationBloc();
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        bloc: loc,
        builder: (context, state) {
          print("LOKASI");
          if (state is LocationInitial) {
            loc.add(GetLocationGps());
          }
          if (state is LocationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LocationFailure) {
            // _controller = Completer<GoogleMapController>();
            loc.add(GetLocationGps(notLoading: true));

            // return Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Container(
            //           width: 300,
            //           height: 180,
            //           child: Image(
            //             image: state.error !=
            //                     "The location service on the device is disabled."
            //                 ? const AssetImage("assets/icons/networkerror.png")
            //                 : const AssetImage("assets/icons/maps.png"),
            //             fit: BoxFit.contain,
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         Text(
            //           state.error ==
            //                   "The location service on the device is disabled."
            //               ? "Gps location is disabled"
            //               : "Network Error!",
            //           style: const TextStyle(
            //             fontSize: 16,
            //             color: Colors.grey,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          }

          if (loc.cordinate != null) {
            loc.add(
              GetRealtimeGps(
                duration: const Duration(seconds: 2),
              ),
            );
            return Column(
              children: [
                Expanded(
                    child: Stack(
                  children: [
                    Maps(loc, _controller),
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
                                        loc.cordinate!.latitude,
                                        loc.cordinate!.longitude,
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
                )),
                SlidingUpPanel(
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
                                          child: Row(
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
                                                    "${loc.address}",
                                                    style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                                "PT. Karya Abadi Suksesido",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Jl. Meranti komplek kehutanan rt.002 rw.003 kel Pasir Jaya, Bogor Barat",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  // color: const Color.fromARGB(
                                                  //     255, 255, 198, 27),
                                                  color: Colors.red[400],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    // color: const Color.fromARGB(
                                                    //     255, 225, 170, 5),
                                                    color: const Color.fromARGB(
                                                        255, 218, 50, 38),
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
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
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
                                                      width: Get.width * 0.8,
                                                      height: Get.width / 1.85,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.white,
                                                        border: Border.all(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              232, 231, 231),
                                                        ),
                                                      ),
                                                      child: const Center(
                                                          child: Icon(
                                                        Icons
                                                            .hide_image_outlined,
                                                        color:
                                                            Color(0xFFE0E0E0),
                                                        size: 100,
                                                      )),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      width: Get.width * 0.8,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
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
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  GoogleMap Maps(LocationBloc loc, Completer<GoogleMapController> _controller) {
    return GoogleMap(
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
          icon: BitmapDescriptor.defaultMarker,
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
          icon: BitmapDescriptor.defaultMarker,
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
          polygonId: PolygonId('area_1'),
          points: [
            LatLng(
              loc.cordinate!.latitude,
              loc.cordinate!.longitude,
            ),
            LatLng(
              loc.cordinate!.latitude,
              loc.cordinate!.longitude,
            ),
            LatLng(
              loc.cordinate!.latitude,
              loc.cordinate!.longitude,
            ),
          ],
          fillColor: Colors.blue.withOpacity(0.5), // Warna area jangkauan
          strokeColor: Colors.blue, // Warna garis tepi area jangkauan
        ),
      },
      circles: Set<Circle>.of([
        Circle(
          circleId: CircleId('myLocation'),
          center: LatLng(
            loc.cordinate!.latitude,
            loc.cordinate!.longitude,
          ), // Koordinat lokasi saat ini
          radius: 50, // Jari-jari dalam meter
          strokeWidth: 2,
          strokeColor: Colors.amber,
          fillColor: Colors.amber.withOpacity(0.2),
        ),
      ]),
    );
  }
}
