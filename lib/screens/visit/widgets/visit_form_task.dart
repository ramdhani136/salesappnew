// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/invoice/invoice_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/task_visit_model.dart';

class VisitFormTask extends StatelessWidget {
  const VisitFormTask({super.key});

  @override
  Widget build(BuildContext context) {
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
            create: (context) => InvoiceBloc()
              ..add(
                InvoiceGetOverDue("${state.data.customer?.erpId}"),
              ),
            child: BlocBuilder<InvoiceBloc, InvoiceState>(
              builder: (context, stateInv) {
                if (stateInv is InvoiceLoadedOverdue) {
                  if (stateInv.data.isNotEmpty) {
                    List setData = stateInv.data.map((item) {
                      return {
                        "_id": item['name'],
                        "from": "Sales Invoice",
                        "name": item['name'],
                        "title": "Tagihan no: ${item['name']}  ",
                        "notes":
                            "Penagihan pembayaran konsumen Invoice no : ${item['name']} dengan total tagihan ${item['outstanding_amount']} dan jatuh tempo pada ${item['due_date']}"
                      };
                    }).toList();
                    ;
                    List<TaskVisitModel> taskFromInv =
                        TaskVisitModel.fromJsonList(setData);
                    dataTask.addAll(taskFromInv);
                  }
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    visitBloc.add(ShowData(id: "${state.data.id}"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: ListView.builder(
                      itemCount: dataTask.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey
                                //         .withOpacity(0.5), // Warna bayangan
                                //     spreadRadius: 3, // Jarak sebar bayangan
                                //     blurRadius: 2, // Jarak blur bayangan
                                //     offset: Offset(0, 4), // Posisi bayangan
                                //   ),
                                // ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
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
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Text(
                                          "${dataTask[index].name} (${dataTask[index].from})",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
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
                                              dataTask[index].title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(dataTask[index].notes),
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
                        );
                      },
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