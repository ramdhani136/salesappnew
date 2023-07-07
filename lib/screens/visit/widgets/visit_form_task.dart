// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/bloc/invoice/invoice_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/task_visit_model.dart';
import 'package:salesappnew/screens/invoice/invoice_form.dart';

class VisitFormTask extends StatelessWidget {
  String visitId;
  VisitFormTask({
    Key? key,
    required this.visitId,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<VisitBloc>(context).add(
      ShowData(
        id: visitId,
        isLoading: false,
      ),
    );
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        VisitBloc visitBloc = BlocProvider.of<VisitBloc>(context);

        if (state is IsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is IsShowLoaded) {
          List<TaskVisitModel> dataTask = state.task;

          return BlocProvider(
            create: (context) => InvoiceBloc(),
            child: BlocBuilder<InvoiceBloc, InvoiceState>(
              builder: (context, stateInv) {
                if (stateInv is InvoiceInitial) {
                  BlocProvider.of<InvoiceBloc>(context).add(
                    InvoiceGetOverDue(
                        customerId: "${state.data.customer?.erpId}"),
                  );
                }
                if (state.data.status == "0" &&
                    stateInv is InvoiceLoadedOverdue) {
                  if (stateInv.data.isNotEmpty) {
                    List setData = stateInv.data.map((item) {
                      var currencyFormat = NumberFormat.currency(
                        locale:
                            'en_US', // sesuaikan dengan locale yang diinginkan
                        symbol:
                            '', // jika Anda ingin menyertakan simbol mata uang, misalnya 'USD', gantikan dengan simbol yang diinginkan
                      );

                      String outstandingAmount =
                          currencyFormat.format(item['outstanding_amount']);
                      return {
                        "_id": item['name'],
                        "from": "Sales Invoice",
                        "name": item['name'],
                        "title": "Tagihan konsumen",
                        "notes":
                            "Penagihan konsumen ${state.data.customer!.erpId} Invoice no : ${item['name']} dengan total tagihan Rp.$outstandingAmount - jatuh tempo pada ${item['due_date']}"
                      };
                    }).toList();
                    ;
                    List<TaskVisitModel> taskFromInv =
                        TaskVisitModel.fromJsonList(setData);
                    dataTask.addAll(taskFromInv);
                  }
                }

                if (dataTask.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    visitBloc.add(ShowData(id: "${state.data.id}"));
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent &&
                              (stateInv is InvoiceLoadedOverdue)
                          ? (stateInv).hasMore
                          : false) {
                        stateInv.hasMore = false;
                        BlocProvider.of<InvoiceBloc>(context).add(
                          InvoiceGetOverDue(
                              customerId: state.data.customer!.erpId!,
                              loadingPage: false),
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
                            itemCount: dataTask.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (dataTask[index].from == "Sales Invoice") {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return InvoiceFormScreen(
                                            id: dataTask[index].name,
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
                                              color: dataTask[index].from !=
                                                      "Sales Invoice"
                                                  ? Colors.yellow[800]
                                                  : Colors.red[400],
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                ),
                                                child: Text(
                                                  "${dataTask[index].name} (${dataTask[index].from})",
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
                                              decoration: BoxDecoration(
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
                                                      dataTask[index].title,
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
                                                      dataTask[index].notes,
                                                      style: TextStyle(
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
                            visible: stateInv is InvoiceInfiniteLoading,
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
              },
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
