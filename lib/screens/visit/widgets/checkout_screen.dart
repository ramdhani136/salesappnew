import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_checkout.dart';
import 'package:salesappnew/widgets/dialog_signature.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VisitBloc, VisitState>(
        builder: (context, state) {
          VisitBloc visitBloc = BlocProvider.of<VisitBloc>(context);
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
                  child: Stack(
                    children: [
                      Column(
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
                                  id: state.data.id.toString(),
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
                          SetCheckOut(id: state.data.id.toString()),
                        );
                        // Aksi saat tombol ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 33, 143, 36),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Check Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
    );
  }
}
