// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, unused_element, non_constant_identifier_names, invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/note/note_bloc.dart';
import 'package:salesappnew/bloc/tags/tags_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';

class FormNote extends StatefulWidget {
  String? noteId;
  String docId;
  FormNote({super.key, this.noteId, required this.docId});

  @override
  State<FormNote> createState() => _FormNoteState();
}

class _FormNoteState extends State<FormNote> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController topicC = TextEditingController();
    final TextEditingController resultC = TextEditingController();
    final TextEditingController activityC = TextEditingController();

    NoteBloc bloc = BlocProvider.of<NoteBloc>(context);
    NoteBloc newBloc = NoteBloc();

    @override
    void dispose() {
      topicC.clear();
      resultC.clear();
      activityC.clear();
      bloc.close();
      newBloc.close();
      super.dispose();
    }

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
              child: ListVisitTags(vnotBloc: newBloc),
            ),
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        bloc.add(
          NoteGetData(
            docId: widget.docId,
          ),
        );

        return true;
      },
      child: BlocBuilder<NoteBloc, NoteState>(
        bloc: bloc
          ..add(
            NoteShowData(id: "${widget.noteId}"),
          ),
        builder: (context, state) {
          if (state is NoteIsLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is NoteShowIsLoaded) {
            newBloc.topic = KeyValue(
              name: state.data['topic']['name'],
              value: state.data['topic']['_id'],
            );
            newBloc.activity = state.data["task"];
            newBloc.feedback = state.data["result"];
            widget.noteId ??= state.data['_id'];
            topicC.text = state.data['topic']['name'];
            resultC.text = state.data['result'];
            if (state.data['task'] != null) {
              activityC.text = state.data['task'];
            }
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
                            NoteGetData(
                              docId: widget.docId,
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
                        BlocBuilder<NoteBloc, NoteState>(
                          bloc: newBloc,
                          builder: (context, stateNew) {
                            bool isChange = false;

                            if (stateNew is NoteShowIsLoaded) {
                              List currentTags =
                                  stateNew.data['tags'].map((dynamic e) {
                                return e['_id'].toString();
                              }).toList();

                              List<String> newTags =
                                  newBloc.tags.map((KeyValue e) {
                                return e.value.toString();
                              }).toList();

                              Set<String> currentSet = Set.from(currentTags);
                              Set<String> newDataSet = Set.from(newTags);

                              bool hasChanges = currentSet
                                      .difference(newDataSet)
                                      .isNotEmpty ||
                                  newDataSet.difference(currentSet).isNotEmpty;

                              if (stateNew.data['topic']["_id"] !=
                                      newBloc.topic?.value ||
                                  hasChanges ||
                                  stateNew.data['task'] != newBloc.activity ||
                                  stateNew.data['result'] != newBloc.feedback) {
                                isChange = true;
                              } else {
                                isChange = false;
                              }
                              widget.noteId = stateNew.data["_id"];
                            } else {
                              if (newBloc.feedback != "" &&
                                  newBloc.activity != "" &&
                                  newBloc.topic != null) {
                                isChange = true;
                              } else {
                                isChange = false;
                              }
                            }

                            return Row(children: [
                              Visibility(
                                visible: status == "0" && isChange,
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
                                                if (widget.noteId != null ||
                                                    stateNew
                                                        is NoteShowIsLoaded) {
                                                  newBloc.add(
                                                    NoteUpdateData(
                                                      id: "${widget.noteId}",
                                                      data: {
                                                        "topic": newBloc
                                                            .topic?.value,
                                                        "task": activityC.text,
                                                        "result": resultC.text,
                                                        "tags": newBloc.tags
                                                            .map((item) =>
                                                                item.value)
                                                            .toList(),
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  newBloc.add(
                                                    NoteAddData(
                                                      data: {
                                                        "topic": newBloc
                                                            .topic?.value,
                                                        "result": resultC.text,
                                                        "task": activityC.text,
                                                        "doc": {
                                                          "type": "visit",
                                                          "_id": widget.docId,
                                                        },
                                                        "tags": newBloc.tags
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
                            ]);
                          },
                        )
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<NoteBloc, NoteState>(
                          bloc: newBloc,
                          builder: (context, stateVisContent) {
                            return Expanded(
                              child: Column(
                                children: [
                                  FieldDataScroll(
                                    textArea: true,
                                    mandatory: true,
                                    endpoint: Endpoint(data: Data.topic),
                                    valid: newBloc.topic?.value == null ||
                                            newBloc.topic?.value == ""
                                        ? false
                                        : true,
                                    value: newBloc.topic?.name ?? "",
                                    title: "Topic",
                                    titleModal: "Topic List",
                                    onSelected: (e) {
                                      newBloc.topic = KeyValue(
                                        name: e['name'],
                                        value: e["_id"],
                                      );
                                      newBloc.emit(NoteInitial());
                                      Get.back();
                                    },
                                    onReset: () {
                                      newBloc.topic = null;
                                      newBloc.emit(NoteInitial());
                                    },
                                    disabled: status != "0",
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Activity",
                                              style: TextStyle(
                                                  color: Colors.grey[700]),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            const Text(
                                              "*",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: TextField(
                                              onChanged: (value) {
                                                newBloc.activity = value;
                                                if (state is NoteShowIsLoaded) {
                                                  newBloc
                                                      .emit(state.copyWith());
                                                } else {
                                                  newBloc.emit(NoteInitial());
                                                }
                                              },
                                              enabled: status == "0",
                                              controller: activityC,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 23, 22, 22)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Feedback",
                                              style: TextStyle(
                                                  color: Colors.grey[700]),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            const Text(
                                              "*",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: TextField(
                                              enabled: status == "0",
                                              controller: resultC,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              onChanged: (value) {
                                                newBloc.feedback = value;
                                                if (state is NoteShowIsLoaded) {
                                                  newBloc
                                                      .emit(state.copyWith());
                                                } else {
                                                  newBloc.emit(NoteInitial());
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 23, 22, 22)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        BlocBuilder<NoteBloc, NoteState>(
                            bloc: newBloc,
                            builder: (context, stateVisitTags) {
                              if (widget.noteId != null &&
                                  stateVisitTags is NoteInitial) {
                                newBloc.add(
                                  NoteShowData(id: "${widget.noteId}"),
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
                                    visible: newBloc.tags.isNotEmpty,
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
                                        children: newBloc.tags.map(
                                          (e) {
                                            return ElevatedButton.icon(
                                              onPressed: () {
                                                if (status == "0") {
                                                  newBloc.add(
                                                    NoteRemoveTag(
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
  NoteBloc vnotBloc;
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
                        BlocBuilder<NoteBloc, NoteState>(
                          bloc: vnotBloc,
                          builder: (context, statevn) {
                            return ListView.builder(
                                itemCount: state.data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      vnotBloc.add(
                                        NoteAddTag(
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
