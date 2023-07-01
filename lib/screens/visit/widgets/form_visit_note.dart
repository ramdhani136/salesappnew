// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/visitnote/visitnote_bloc.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';

void FormVisitNote({
  required BuildContext context,
  required VisitnoteBloc bloc,
  String? noteId,
  String? visitId,
}) {
  final TextEditingController titleC = TextEditingController();
  final TextEditingController noteC = TextEditingController();
  String? id;
  List tags = [];

  if (noteId != null) {
    id = noteId;
  }

  VisitnoteBloc vBloc = VisitnoteBloc();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          if (visitId != null) {
            bloc.add(
              GetVisitNote(
                visitId: visitId,
              ),
            );
          }

          return true;
        },
        child: BlocBuilder<VisitnoteBloc, VisitnoteState>(
          bloc: vBloc,
          builder: (context, state) {
            if (state is VisitNoteIsFailure) {}

            if (id != null && visitId != null && state is VisitnoteInitial) {
              vBloc.add(
                ShowVisitNote(id: "${id}"),
              );
            }

            if (state is VisitNoteIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is VisitNoteShow) {
              tags = state.data['tags'];
              id ??= state.data['_id'];
              titleC.text = state.data['title'];
              noteC.text = state.data['notes'];
            }

            return Column(
              children: [
                Container(
                    width: Get.width, color: Color(0xFFE6212A), height: 50),
                AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color(0xFFE6212A),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButtonCustom(onBack: () {
                        if (visitId != null) {
                          bloc.add(
                            GetVisitNote(
                              visitId: visitId,
                            ),
                          );
                        }
                      }),
                      const Row(
                        children: [
                          Icon(Icons.note, size: 17),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: Text(
                              "Notes",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        // IconSearch(),
                        IconButton(
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute<VisitForm>(
                            //     builder: (_) => MultiBlocProvider(
                            //       providers: [
                            //         BlocProvider.value(
                            //           value: BlocProvider.of<AuthBloc>(context),
                            //         ),
                            //       ],
                            //       child: VisitForm(),
                            //     ),
                            //   ),
                            // );
                          },
                          icon: const Icon(
                            Icons.attach_file_rounded,
                            color: Color.fromARGB(255, 121, 8, 14),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
                Expanded(
                  child: Scaffold(
                    backgroundColor: Colors.grey[200],
                    body: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: titleC,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText: 'Title',
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight
                                  .bold, // Menentukan teks menjadi tebal (bold)
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: TextField(
                                controller: noteC,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Notes Content',
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Tags :",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.width,
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                            child: Wrap(
                              children: tags.map((e) {
                                return ElevatedButton.icon(
                                  onPressed: () {
                                    print(e['_id']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green[
                                        800], // Warna latar belakang tombol
                                  ),
                                  icon: Icon(
                                    Icons.clear,
                                    size: 16,
                                  ),
                                  label: Text(e['name']),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    floatingActionButton: Visibility(
                        visible: true,
                        child: SizedBox(
                          height: 250.0,
                          width: 60.0,
                          child: FloatingActionButton(
                            onPressed: () {
                              if (id != null) {
                                vBloc.add(UpdateVisitNote(
                                  id: "${id}",
                                  data: {
                                    "title": titleC.text,
                                    "notes": noteC.text
                                  },
                                ));
                              } else {
                                vBloc.add(InsertVisitNote(
                                  data: {
                                    "title": titleC.text,
                                    "notes": noteC.text,
                                    "visitId": visitId,
                                    "tags": ["648035669c2e5446ae9218f3"],
                                  },
                                ));
                              }
                            },
                            backgroundColor: Colors.grey[850],
                            child: const Icon(Icons.save),
                          ),
                        )),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
