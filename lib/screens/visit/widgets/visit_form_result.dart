// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/note/note_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/screens/visit/widgets/form_note.dart';

class VisitFormResult extends StatelessWidget {
  String visitId;
  VisitFormResult({super.key, required this.visitId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NoteBloc()
          ..add(
            NoteGetData(
              docId: visitId,
            ),
          ),
        child: Scaffold(
          body: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);

              if (state is NoteDeleteSuccess) {
                noteBloc.add(NoteGetData(docId: visitId));
              }

              if (state is NoteIsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is NoteIsLoaded) {
                return Stack(
                  children: [
                    RefreshIndicator(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent &&
                              state.hasMore) {
                            state.hasMore = false;
                            noteBloc.add(
                              NoteGetData(
                                docId: visitId,
                                refresh: false,
                              ),
                            );
                          }
                          return false;
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: ListView.builder(
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Visibility(
                                    visible: index == 0,
                                    child: const SizedBox(
                                      height: 20,
                                    ),
                                  ),
                                  InkWell(
                                    onLongPress: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Really?"),
                                            content: const Text(
                                                "You want to delete this data??"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("No"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  try {
                                                    noteBloc.add(
                                                      NoteDeleteData(
                                                        id: state.data[index].id
                                                            .toString(),
                                                      ),
                                                    );
                                                    Get.back();
                                                  } catch (e) {
                                                    rethrow;
                                                  }
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute<FormNote>(
                                          builder: (_) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                value:
                                                    BlocProvider.of<NoteBloc>(
                                                        context),
                                              ),
                                              BlocProvider.value(
                                                value:
                                                    BlocProvider.of<VisitBloc>(
                                                        context),
                                              ),
                                            ],
                                            child: FormNote(
                                              visitId: visitId,
                                              noteId: state.data[index].id,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          IntrinsicHeight(
                                            child: Container(
                                              width: Get.width,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 12,
                                                  right: 12,
                                                  bottom: 12,
                                                  top: 8,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.data[index].topic!
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: state.data[index]
                                                              .task !=
                                                          null,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            state.data[index]
                                                                .task
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15.5,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      state.data[index].result!,
                                                      style: const TextStyle(
                                                        fontSize: 15.5,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      DateFormat.yMd()
                                                          .add_jm()
                                                          .format(
                                                            DateTime.parse(
                                                                    "${state.data[index].updatedAt}")
                                                                .toLocal(),
                                                          ),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13.5,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: Get.width,
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    227,
                                                                    225,
                                                                    225),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Wrap(
                                                          children: state
                                                              .data[index].tags!
                                                              .map((item) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 5,
                                                                bottom: 5,
                                                              ),
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        6.0,
                                                                    vertical:
                                                                        4.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .green[
                                                                      800],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                ),
                                                                child: Text(
                                                                  item.name!,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        13.0,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      onRefresh: () async {
                        noteBloc.add(
                          NoteGetData(
                            docId: visitId,
                          ),
                        );
                      },
                    ),
                    Visibility(
                      visible: state.IsloadingPage,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
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
              return const Center(
                child: Text(
                  "No data",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
          floatingActionButton: BlocBuilder<VisitBloc, VisitState>(
            builder: (context, state) {
              if (state is IsShowLoaded) {
                return Visibility(
                  visible: state.data.status == "0",
                  child: SizedBox(
                    height: 70.0,
                    width: 60.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<FormNote>(
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: BlocProvider.of<NoteBloc>(context),
                                ),
                                BlocProvider.value(
                                  value: BlocProvider.of<VisitBloc>(context),
                                ),
                              ],
                              child: FormNote(visitId: state.data.id!),
                            ),
                          ),
                        );
                      },
                      backgroundColor: Colors.grey[850],
                      child: const Icon(Icons.add),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ));
  }
}
