import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_checkout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesappnew/widgets/dialog_signature.dart';

void showCheckInModal(BuildContext context, VisitBloc visitBloc, String id) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Membuat modal menggunakan tinggi penuh
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: Get.width, // Lebar penuh
          // height: 300, // Tinggi penuh
          height: MediaQuery.of(context).size.height, // Tinggi penuh
          child: BlocBuilder<VisitBloc, VisitState>(
            bloc: visitBloc,
            builder: (context, state) {
              if (state is IsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is IsShowLoaded) {
                if (state.data.checkOut != null) {
                  Navigator.of(context).pop();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // InkWell(
                    //   child: Text('Tutup'),
                    //   onTap: () {
                    //     Navigator.of(context).pop(); // Menutup modal
                    //   },
                    // ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: VisitCheckOut(
                              checkInCordinate: LatLng(
                                state.data.checkIn!.lat!,
                                state.data.checkIn!.lng!,
                              ),
                              visitBloc: visitBloc,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    DialogSignature(
                                  id: id,
                                  visitBloc: visitBloc,
                                ),
                              );
                            },
                            child: Container(
                              width: Get.width,
                              height: Get.width / 1.5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(
                                    255,
                                    225,
                                    225,
                                    225,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                              child: visitBloc.signature == null
                                  ? Center(
                                      child: Text(
                                        "Please sign",
                                        style:
                                            TextStyle(color: Colors.grey[300]),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Image.memory(visitBloc.signature!),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Visibility(
                        visible: visitBloc.signature != null &&
                            visitBloc.checkOutCordinates != null,
                        child: ElevatedButton(
                          onPressed: () {
                            visitBloc.add(
                              SetCheckOut(id: id),
                            );
                            // Aksi saat tombol ditekan
                          },
                          child: Text(
                            'Check Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 33, 143, 36),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    )

                    // Text('Isi modal kustom'),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      );
    },
  );
}
