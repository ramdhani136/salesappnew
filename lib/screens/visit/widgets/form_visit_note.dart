// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, unused_element, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/tags/tags_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/bloc/visitnote/visitnote_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:salesappnew/widgets/custom_field.dart';

class FormVisitNote extends StatelessWidget {
  String? noteId;
  String visitId;
  FormVisitNote({super.key, this.noteId, required this.visitId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleC = TextEditingController();
    final TextEditingController noteC = TextEditingController();

    VisitnoteBloc bloc = BlocProvider.of<VisitnoteBloc>(context);
    VisitnoteBloc vBloc = VisitnoteBloc();
    VisitnoteBloc vContentBloc = VisitnoteBloc();
    VisitnoteBloc vTagsBloc = VisitnoteBloc();

    void _showListTags(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(
                0), // Menghapus padding inset bawaan dialog
            child: Container(
              width: Get.width - 20,
              height: Get.height - 50,
              padding:
                  const EdgeInsets.all(20), // Mengambil lebar layar perangkat
              child: ListVisitTags(vnotBloc: vTagsBloc),
            ),
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (noteId != null) {
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
          if (noteId != null && state is VisitnoteInitial) {
            vBloc.add(
              ShowVisitNote(id: "$noteId"),
            );
          }

          if (state is VisitNoteIsLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is VisitNoteShow) {
            noteId ??= state.data['_id'];
            titleC.text = state.data['title'];
            noteC.text = state.data['notes'];
          }

          return BlocBuilder(
              bloc: BlocProvider.of<VisitBloc>(context),
              builder: (context, stateVisit) {
                String status = "1";
                if (stateVisit is IsShowLoaded) {
                  status = stateVisit.data.status!;
                }
                return Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: const Color(0xFFE6212A),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButtonCustom(onBack: () {
                          bloc.add(
                            GetVisitNote(
                              visitId: visitId,
                            ),
                          );
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
                          // PopupMenuButton(
                          //   padding: const EdgeInsets.all(0),
                          //   icon: const Icon(
                          //     Icons.attach_file_rounded,
                          //     color: Color.fromARGB(255, 121, 8, 14),
                          //   ),
                          //   itemBuilder: (context) {
                          //     List<Map<String, dynamic>> choose = [
                          //       {'action': 'Attach File'},
                          //       {'action': 'Take Photo'},
                          //     ];
                          //     return choose.map((item) {
                          //       return PopupMenuItem(
                          //         child: InkWell(
                          //           onTap: () async {
                          //             Get.back();
                          //           },
                          //           child: Padding(
                          //             padding: const EdgeInsets.symmetric(
                          //                 horizontal: 10, vertical: 10),
                          //             child: Text(item['action']),
                          //           ),
                          //         ),
                          //       );
                          //     }).toList();
                          //   },
                          // ),
                          Visibility(
                            visible: status == "0",
                            child: IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Really?"),
                                      content: const Text(
                                          "You want to save this data??"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            if (noteId != null) {
                                              vBloc.add(
                                                UpdateVisitNote(
                                                  id: "$noteId",
                                                  data: {
                                                    "title": titleC.text,
                                                    "notes": noteC.text,
                                                    "tags": vTagsBloc.tags
                                                        .map((item) =>
                                                            item.value)
                                                        .toList(),
                                                  },
                                                ),
                                              );
                                            } else {
                                              vBloc.add(
                                                InsertVisitNote(
                                                  data: {
                                                    "title": titleC.text,
                                                    "notes": noteC.text,
                                                    "visitId": visitId,
                                                    "tags": vTagsBloc.tags
                                                        .map((item) =>
                                                            item.value)
                                                        .toList(),
                                                  },
                                                ),
                                              );
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Yes"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.check,
                                color: Color.fromARGB(255, 121, 8, 14),
                              ),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<VisitnoteBloc, VisitnoteState>(
                          bloc: vContentBloc,
                          builder: (context, stateVisContent) {
                            return Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autofocus: true,
                                    enabled: status == "0",
                                    controller: titleC,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      // border: InputBorder.none,
                                      hintText: 'Title',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold, //
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      enabled: status == "0",
                                      controller: noteC,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      textInputAction: TextInputAction.done,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Notes Content',
                                      ),
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 22, 22)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        BlocBuilder<VisitnoteBloc, VisitnoteState>(
                            bloc: vTagsBloc,
                            builder: (context, stateVisitTags) {
                              if (noteId != null &&
                                  stateVisitTags is VisitnoteInitial) {
                                vTagsBloc.add(
                                  ShowVisitNote(id: "$noteId"),
                                );
                              }

                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Tags :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Visibility(
                                        visible: status == "0",
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _showListTags(context);
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color.fromARGB(
                                                  255, 61, 153, 64),
                                            ),
                                          ),
                                          child: const Text("Add"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Visibility(
                                    visible: vTagsBloc.tags.isNotEmpty,
                                    child: Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 8,
                                        bottom: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                      ),
                                      child: Wrap(
                                        spacing: 5,
                                        children: vTagsBloc.tags.map(
                                          (e) {
                                            return ElevatedButton.icon(
                                              onPressed: () {
                                                if (status == "0") {
                                                  vTagsBloc.add(
                                                    VisitNoteRemoveTag(
                                                      tag: KeyValue(
                                                          name: e.name,
                                                          value: e.value),
                                                    ),
                                                  );
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.grey[800],
                                                minimumSize: const Size(30, 32),
                                              ),
                                              icon: const Icon(
                                                Icons.clear,
                                                size: 16,
                                              ),
                                              label: Text(e.name),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                  // floatingActionButton: Visibility(
                  //   visible: status == "0",
                  //   child: Padding(
                  //     padding: EdgeInsets.only(
                  //         bottom: vBloc.tags.isEmpty ? 80 : 150),
                  //     child: SizedBox(
                  //       height: 65.0,
                  //       width: 65.0,
                  //       child: FloatingActionButton(
                  //         onPressed: () {
                  //           if (noteId != null) {
                  //             vBloc.add(
                  //               UpdateVisitNote(
                  //                 id: "$noteId",
                  //                 data: {
                  //                   "title": titleC.text,
                  //                   "notes": noteC.text,
                  //                   "tags": vBloc.tags
                  //                       .map((item) => item.value)
                  //                       .toList(),
                  //                 },
                  //               ),
                  //             );
                  //           } else {
                  //             vBloc.add(
                  //               InsertVisitNote(
                  //                 data: {
                  //                   "title": titleC.text,
                  //                   "notes": noteC.text,
                  //                   "visitId": visitId,
                  //                   "tags": vBloc.tags
                  //                       .map((item) => item.value)
                  //                       .toList(),
                  //                 },
                  //               ),
                  //             );
                  //           }
                  //         },
                  //         backgroundColor: Colors.grey[850],
                  //         child: const Icon(Icons.save),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                );
              });
        },
      ),
    );
  }
}

class FormVisitTag extends StatelessWidget {
  TagsBloc bloc = TagsBloc();
  FormVisitTag({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController nameC = TextEditingController(text: bloc.search);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomField(
          controller: nameC,
          type: Type.standard,
          title: "Name",
          placeholder: "Tag name",
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              bloc.add(
                TagInsert(data: {
                  "name": nameC.text,
                }),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(
                  255, 57, 156, 60), // Mengatur warna latar belakang
            ),
            child: const Text(
              "Save",
            ),
          ),
        ),
      ],
    );
  }
}

class ListVisitTags extends StatelessWidget {
  VisitnoteBloc vnotBloc;
  ListVisitTags({
    super.key,
    required this.vnotBloc,
  });

  @override
  Widget build(BuildContext context) {
    TagsBloc bloc = TagsBloc()
      ..add(
        TagGetAll(),
      );

    TextEditingController searchC = TextEditingController();

    Timer? debounceTimer;

    void ShowformTags(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(
                0), // Menghapus padding inset bawaan dialog
            child: Container(
              width: Get.width - 50,
              padding:
                  const EdgeInsets.all(20), // Mengambil lebar layar perangkat
              child: FormVisitTag(bloc: bloc),
            ),
          );
        },
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Tag List",
              style: TextStyle(
                color: Color.fromARGB(255, 66, 66, 66),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocBuilder<TagsBloc, TagsState>(
          bloc: bloc,
          builder: (context, state) {
            return TextField(
              onChanged: (e) {
                debounceTimer?.cancel();
                debounceTimer = Timer(
                  const Duration(milliseconds: 40),
                  () {
                    bloc.add(TagChangeSearch(e));
                    bloc.add(
                      TagGetAll(search: e),
                    );
                  },
                );
              },
              autofocus: true,
              controller: searchC,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                suffixIcon: Visibility(
                  visible: bloc.search != "",
                  child: IconButton(
                    onPressed: () async {
                      searchC.text = "";
                      bloc.add(
                        TagChangeSearch(""),
                      );
                      bloc.add(
                        TagGetAll(),
                      );
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                hintStyle: TextStyle(color: Colors.grey[300]),
                hintText: "Search",
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue, // Warna border yang diinginkan
                    width: 1.0, // Ketebalan border
                  ),
                  borderRadius: BorderRadius.circular(
                    4,
                  ), // Sudut melengkung pada border
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {}
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                bloc.add(
                  TagGetAll(
                    search: bloc.search,
                  ),
                );
              },
              child: BlocBuilder<TagsBloc, TagsState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is TagsIsLoaded) {
                    return Stack(
                      children: [
                        BlocBuilder<VisitnoteBloc, VisitnoteState>(
                          bloc: vnotBloc,
                          builder: (context, statevn) {
                            return ListView.builder(
                                itemCount: state.data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      vnotBloc.add(
                                        VisitNoteAddTag(
                                          tag: KeyValue(
                                            name: state.data[index]['name'],
                                            value: state.data[index]['_id'],
                                          ),
                                        ),
                                      );
                                      Get.back();
                                    },
                                    title: Text(state.data[index]['name']),
                                  );
                                });
                          },
                        ),
                        Visibility(
                          visible: state.pageLoading,
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is tagsIsFailure) {
                    return Center(
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.error,
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: state.error == "Data Not found!",
                              child: ElevatedButton(
                                onPressed: () {
                                  ShowformTags(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 57,
                                      156, 60), // Mengatur warna latar belakang
                                ),
                                child: const Text(
                                  "Create New",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
