// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/callsheet/callsheet_bloc.dart';
import 'package:salesappnew/bloc/callsheetnote/callsheetnote_bloc.dart';
import 'package:salesappnew/screens/callsheet/widgets/form_callsheet_note.dart';
import 'package:salesappnew/utils/fetch_data.dart';

class CallsheetFormTask extends StatelessWidget {
  String id;
  CallsheetFormTask({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsheetBloc, CallsheetState>(
      builder: (context, state) {
        CallsheetBloc bloc = BlocProvider.of<CallsheetBloc>(context);

        if (state is CallsheetIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CallsheetIsShowLoaded) {
          if (state.task.isEmpty) {
            return Center(
              child: Text(
                "No Data",
                style: TextStyle(color: Colors.grey[500]),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              bloc.add(CallsheetShowData(id: "${state.data.id}"));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: state.task.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onLongPress: () {
                          if (state.data.status == "0") {
                            Get.defaultDialog(
                              title: '',
                              content:
                                  const Text("Create notes for this task?"),
                              contentPadding: const EdgeInsets.all(16),
                              actions: [
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey[400]!),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green[400]!),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  onPressed: () async {
                                    EasyLoading.show(status: 'loading...');
                                    Get.back();

                                    try {
                                      late String typeTag;
                                      late String nameTag;
                                      dynamic cekTags = await FetchData(
                                        data: Data.tag,
                                      ).FINDALL(
                                        fields: ["_id", "name"],
                                        filters: [
                                          ["name", "=", state.task[index].from],
                                        ],
                                      );

                                      if (cekTags['status'] != 200) {
                                        dynamic cekOSTags = await FetchData(
                                          data: Data.tag,
                                        ).ADD(
                                          {"name": state.task[index].from},
                                        );

                                        typeTag = cekOSTags['data']['_id'];
                                      } else {
                                        typeTag = cekTags['data'][0]["_id"];
                                      }

                                      dynamic cekNameTag = await FetchData(
                                        data: Data.tag,
                                      ).FINDALL(
                                        fields: ["_id", "name"],
                                        filters: [
                                          ["name", "=", state.task[index].name],
                                        ],
                                      );

                                      if (cekNameTag['status'] != 200) {
                                        dynamic createNameTag = await FetchData(
                                          data: Data.tag,
                                        ).ADD(
                                          {"name": state.task[index].name},
                                        );

                                        nameTag = createNameTag['data']['_id'];
                                      } else {
                                        nameTag = cekNameTag['data'][0]["_id"];
                                      }

                                      dynamic insertTask = await FetchData(
                                        data: Data.callsheetNote,
                                      ).ADD(
                                        {
                                          "title":
                                              "${state.task[index].from} ${state.task[index].name}",
                                          "callsheetId": id,
                                          "tags": [
                                            typeTag,
                                            nameTag,
                                          ],
                                          "notes": state.task[index].notes,
                                        },
                                      );

                                      if (insertTask['status'] != 200) {
                                        throw insertTask['msg'];
                                      }
                                      Get.to(
                                        () => MultiBlocProvider(
                                          providers: [
                                            BlocProvider.value(
                                              value: CallsheetnoteBloc(),
                                            ),
                                            BlocProvider.value(
                                              value: BlocProvider.of<
                                                  CallsheetBloc>(context),
                                            ),
                                          ],
                                          child: FormCallsheetNote(
                                            callsheetId: state.data.id!,
                                            noteId: insertTask['data']['_id'],
                                          ),
                                        ),
                                      );

                                      EasyLoading.dismiss();
                                    } catch (e) {
                                      EasyLoading.dismiss();
                                      Get.defaultDialog(
                                        content: Text(
                                          e.toString(),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 20,
                                        ),
                                      );
                                      rethrow;
                                    }
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Visibility(
                              visible: index == 0,
                              child: const SizedBox(
                                height: 20,
                              ),
                            ),
                            Container(
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
                                children: [
                                  Container(
                                    width: Get.width,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      color: state.task[index].from !=
                                              "Sales Invoice"
                                          ? Colors.yellow[800]
                                          : Colors.red[400],
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Text(
                                          "${state.task[index].name} (${state.task[index].from})",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Container(
                                      width: Get.width,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
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
                                              state.task[index].title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              state.task[index].notes,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: Text(
            "No Task",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
