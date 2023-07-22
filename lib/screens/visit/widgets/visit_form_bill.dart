// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unnecessary_type_check
// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/invoice/invoice_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/bloc/visitnote/visitnote_bloc.dart';
import 'package:salesappnew/models/task_visit_model.dart';
import 'package:salesappnew/screens/invoice/invoice_form.dart';
import 'package:salesappnew/screens/visit/widgets/form_visit_note.dart';
import 'package:salesappnew/utils/fetch_data.dart';

class VisitFormBill extends StatelessWidget {
  String visitId;
  VisitFormBill({
    Key? key,
    required this.visitId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisitBloc visitBloc = BlocProvider.of<VisitBloc>(context);
    InvoiceBloc invBloc = InvoiceBloc();
    return BlocBuilder<VisitBloc, VisitState>(
      bloc: visitBloc
        ..add(
          ShowData(
            id: visitId,
            isLoading: false,
          ),
        ),
      builder: (context, state) {
        if (state is IsShowLoaded) {
          return BlocProvider(
            create: (context) => InvoiceBloc(),
            child: BlocBuilder<InvoiceBloc, InvoiceState>(
              bloc: invBloc
                ..add(
                  InvoiceGetOverDue(
                      customerId: "${state.data.customer?.erpId}"),
                ),
              builder: (context, stateInv) {
                if (stateInv is InvoiceFailure) {
                  return Center(
                    child: Text(
                      stateInv.error,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                if (state.data.status != "0" &&
                    stateInv is InvoiceLoadedOverdue) {
                  return const Center(
                    child: Text(
                      "No Data",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                if (state.data.status == "0" &&
                    stateInv is InvoiceLoadedOverdue) {
                  List<TaskVisitModel> taskFromInv =
                      TaskVisitModel.fromJsonList(
                    stateInv.data,
                  );

                  return RefreshIndicator(
                    onRefresh: () async {
                      invBloc.add(
                        InvoiceGetOverDue(
                          getRefresh: true,
                          customerId: "${state.data.customer?.erpId}",
                        ),
                      );
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent &&
                                (stateInv is InvoiceLoadedOverdue)
                            ? (stateInv).hasMore
                            : false) {
                          stateInv.hasMore = false;
                          invBloc.add(
                            InvoiceGetOverDue(
                              customerId: state.data.customer!.erpId!,
                              getRefresh: false,
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
                        child: Stack(
                          children: [
                            ListView.builder(
                              itemCount: taskFromInv.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onLongPress: () {
                                    if (state.data.status == "0") {
                                      Get.defaultDialog(
                                        title: '',
                                        content: const Text(
                                            "Create notes for this bill?"),
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        actions: [
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.grey[400]!),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Colors.green[400]!),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                            ),
                                            onPressed: () async {
                                              EasyLoading.show(
                                                  status: 'loading...');
                                              Get.back();
                                              try {
                                                late String outstandingTags;
                                                late String nameTag;
                                                dynamic cekTags =
                                                    await FetchData(
                                                  data: Data.tag,
                                                ).FINDALL(
                                                  fields: ["_id", "name"],
                                                  filters: [
                                                    [
                                                      "name",
                                                      "=",
                                                      "Outstanding"
                                                    ],
                                                  ],
                                                );

                                                if (cekTags['status'] != 200) {
                                                  dynamic cekOSTags =
                                                      await FetchData(
                                                    data: Data.tag,
                                                  ).ADD(
                                                    {"name": "Outstanding"},
                                                  );

                                                  outstandingTags =
                                                      cekOSTags['data']['_id'];
                                                } else {
                                                  outstandingTags =
                                                      cekTags['data'][0]["_id"];
                                                }

                                                dynamic cekNameTag =
                                                    await FetchData(
                                                  data: Data.tag,
                                                ).FINDALL(
                                                  fields: ["_id", "name"],
                                                  filters: [
                                                    [
                                                      "name",
                                                      "=",
                                                      taskFromInv[index].name
                                                    ],
                                                  ],
                                                );

                                                if (cekNameTag['status'] !=
                                                    200) {
                                                  dynamic createNameTag =
                                                      await FetchData(
                                                    data: Data.tag,
                                                  ).ADD(
                                                    {
                                                      "name": taskFromInv[index]
                                                          .name
                                                    },
                                                  );

                                                  nameTag =
                                                      createNameTag['data']
                                                          ['_id'];
                                                } else {
                                                  nameTag = cekNameTag['data']
                                                      [0]["_id"];
                                                }

                                                dynamic insertTask =
                                                    await FetchData(
                                                            data:
                                                                Data.visitnote)
                                                        .ADD(
                                                  {
                                                    "title":
                                                        "Outstanding inv ${taskFromInv[index].name}",
                                                    "visitId": visitId,
                                                    "tags": [
                                                      outstandingTags,
                                                      nameTag,
                                                    ],
                                                    "notes": taskFromInv[index]
                                                        .notes,
                                                  },
                                                );

                                                if (insertTask['status'] !=
                                                    200) {
                                                  throw insertTask['msg'];
                                                }

                                                Get.to(
                                                  () => MultiBlocProvider(
                                                    providers: [
                                                      BlocProvider.value(
                                                        value: VisitnoteBloc(),
                                                      ),
                                                      BlocProvider.value(
                                                        value: BlocProvider.of<
                                                            VisitBloc>(context),
                                                      ),
                                                    ],
                                                    child: FormVisitNote(
                                                      visitId: state.data.id!,
                                                      noteId: insertTask['data']
                                                          ['_id'],
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
                                                      const EdgeInsets
                                                          .symmetric(
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
                                  onTap: () {
                                    if (taskFromInv[index].from ==
                                        "Sales Invoice") {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return InvoiceFormScreen(
                                              id: taskFromInv[index].name,
                                            );
                                          },
                                        ),
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
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                color:
                                                    taskFromInv[index].from !=
                                                            "Sales Invoice"
                                                        ? Colors.yellow[800]
                                                        : Colors.red[400],
                                              ),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 15,
                                                  ),
                                                  child: Text(
                                                    "${taskFromInv[index].name} (${taskFromInv[index].from})",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 12,
                                                    right: 12,
                                                    bottom: 12,
                                                    top: 8,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        taskFromInv[index]
                                                            .title,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        taskFromInv[index]
                                                            .notes,
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
                            Visibility(
                              visible: stateInv.pageLoading,
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
                        ),
                      ),
                    ),
                  );
                }
                if (stateInv is InvoiceFailure) {
                  return Center(
                    child: Text(
                      stateInv.error,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  );
                }

                return Container();
              },
            ),
          );
        }
        return const Center(
          child: Text(
            "No Data",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
