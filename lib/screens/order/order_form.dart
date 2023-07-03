// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/order/order_bloc.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:intl/intl.dart';

class OrderFormScreen extends StatelessWidget {
  String id;
  OrderFormScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(
      locale: 'id',
    );
    return BlocProvider(
      create: (context) => OrderBloc()
        ..add(
          GetOrdershow(id: id),
        ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFE6212A),
          title: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderIsLoading) {
                return const Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                );
              }
              if (state is OrderShowIsLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonCustom(),
                    const Row(
                      children: [
                        Icon(Icons.currency_exchange, size: 17),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            "Sales Order",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<OrderBloc>(context).add(
                              GetOrdershow(id: id),
                            );
                          },
                          icon: const Icon(
                            Icons.refresh,
                            color: Color.fromARGB(255, 121, 8, 14),
                          ),
                        ),
                        Visibility(
                          visible: state.workflow.isNotEmpty,
                          child: PopupMenuButton(
                            padding: const EdgeInsets.all(0),
                            icon: const Icon(
                              Icons.more_vert,
                              color: Color.fromARGB(255, 121, 8, 14),
                            ),
                            itemBuilder: (context) {
                              return state.workflow.map((item) {
                                return PopupMenuItem(
                                  child: InkWell(
                                    onTap: () async {
                                      Get.back();
                                      // BlocProvider.of<InvoiceBloc>(context).add(
                                      //   ChangeWorkflow(
                                      //       id: id, nextStateId: item.nextState.id),
                                      // );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(item['action']),
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonCustom(),
                  const Text(
                    "Sales Order",
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<OrderBloc>(context).add(
                        GetOrdershow(id: id),
                      );
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Color.fromARGB(255, 121, 8, 14),
                    ),
                  ),
                ],
              );
            },
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is OrderShowIsLoaded) {
              return Column(
                children: [
                  Container(
                    width: Get.width,
                    constraints: const BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 215, 28, 38),
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(
                                255,
                                215,
                                28,
                                38,
                              ),
                              width: 1)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: Get.width * 0.9,
                          child: Text(
                            textAlign: TextAlign.center,
                            '${state.data.customerName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          child: Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.33),
                              1: FractionColumnWidth(0.07),
                              2: FractionColumnWidth(0.6),
                            },
                            children: [
                              buildRow([
                                'Invoice Number',
                                ':',
                                '${state.data.name}'
                              ]),
                              buildRow([
                                'Transaction on',
                                ':',
                                (DateFormat.yMMMEd().add_jm().format(
                                      DateTime.parse("${state.data.creation}")
                                          .toLocal(),
                                    )),
                              ]),
                              buildRow([
                                'Group',
                                ':',
                                '${state.data.customerGroup}'
                              ]),
                              buildRow([
                                'Price List',
                                ':',
                                '${state.data.sellingPriceList}'
                              ]),
                              buildRow([
                                'Warehouse',
                                ':',
                                '${state.data.setWarehouse}'
                              ]),
                              // buildRow([
                              //   'Outstanding',
                              //   ':',
                              //   (formatCurrency
                              //       .format(state.data.outstandingAmount))
                              // ]),
                              buildRow(['Status', ':', '${state.data.status}']),
                              // buildRow([
                              //   'Transaction on',
                              //   ':',
                              //   (DateFormat.yMMMEd().add_jm().format(
                              //         DateTime.parse("${state.data.dueDate}")
                              //             .toLocal(),
                              //       )),
                              // ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: Get.width,
                            height: 45,
                            decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Color.fromARGB(
                                        255,
                                        215,
                                        28,
                                        38,
                                      ),
                                      width: 1)),
                              color: Color.fromARGB(
                                255,
                                215,
                                28,
                                38,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.05),
                              width: Get.width * 0.9,
                              height: Get.height * 0.8,
                              child: ListView.builder(
                                itemCount: state.data.items!.length,
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.only(bottom: 11),
                                  width: Get.width,
                                  constraints: const BoxConstraints(
                                    maxHeight: double.infinity,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: const Color.fromARGB(
                                          255, 200, 200, 200),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(18.0),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${state.data.items![index].itemCode}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            Text(
                                              "${state.data.items![index].qty} ${state.data.items![index].uom}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.5,
                                              child: Text(
                                                "${state.data.items![index].itemName}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "@ ${formatCurrency.format(state.data.items![index].rate)}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[900],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              formatCurrency.format(state
                                                  .data.items![index].amount),
                                              style: const TextStyle(
                                                fontSize: 19,
                                                color: Color.fromARGB(
                                                    255, 203, 25, 34),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        215,
                        28,
                        38,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                formatCurrency.format(state.data.grandTotal),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  state is OrderIsFailure
                      ? (state as OrderIsFailure).error
                      : "No Data",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign:
                      TextAlign.center, // Menyebabkan teks menjadi rata tengah
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

TableRow buildRow(List<String> cells) => TableRow(
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            cell,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
