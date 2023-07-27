// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/bin/bin_bloc.dart';
import 'package:salesappnew/bloc/item/item_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:intl/intl.dart';

class ItemFormScreen extends StatelessWidget {
  String id;
  ItemFormScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('en_US');
    return BlocProvider(
      create: (context) => ItemBloc()
        ..add(
          GetItemShow(id: id),
        ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFE6212A),
          title: BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              if (state is ItemIsLoading) {
                return const Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                );
              }
              if (state is ItemShowIsLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonCustom(),
                    const Row(
                      children: [
                        Icon(Icons.assignment, size: 17),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            "Item List",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<ItemBloc>(context).add(
                              GetItemShow(id: id),
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
                    "Item List",
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<ItemBloc>(context).add(
                        GetItemShow(id: id),
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
        body: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is ItemIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ItemShowIsLoaded) {
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
                            '${state.data.itemName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 20,
                          ),
                          child: Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.33),
                              1: FractionColumnWidth(0.07),
                              2: FractionColumnWidth(0.6),
                            },
                            // border: TableBorder.all(),
                            children: [
                              buildRow(
                                  ['Item Code', ':', '${state.data.name}']),
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
                                state.data.itemGroup != null
                                    ? '${state.data.itemGroup}'
                                    : 'No data'
                              ]),
                              buildRow([
                                'Stocker',
                                ':',
                                state.data.stocker != null
                                    ? '${state.data.stocker}'
                                    : 'No data'
                              ]),
                              buildRow(['UOM', ':', '${state.data.stockUom}']),
                              buildRow([
                                'Status',
                                ':',
                                (state.data.disabled == 0
                                    ? "Active"
                                    : "Disabled")
                              ]),
                              buildRow([
                                'Workflow State',
                                ':',
                                '${state.data.workflowState}'
                              ]),
                            ],
                          ),
                        ),
                        BlocBuilder<BinBloc, BinState>(
                          bloc: BinBloc()
                            ..add(
                              GetBinByItem(
                                itemId: state.data.itemCode!,
                              ),
                            ),
                          builder: (context, stateBin) {
                            if (stateBin is BinIsLoading) {
                              return Container(
                                width: 10,
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              );
                            }
                            if (stateBin is BinByItemIsLoaded) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 20),
                                child: Visibility(
                                  visible: stateBin.data.isNotEmpty,
                                  child: Table(
                                    columnWidths: const {
                                      0: FractionColumnWidth(0.33),
                                      1: FractionColumnWidth(0.07),
                                      2: FractionColumnWidth(0.6),
                                    },
                                    // border: TableBorder.all(),
                                    children: [
                                      buildRow([
                                        'Actual Qty',
                                        ':',
                                        numberFormat.format(
                                          stateBin.data[0].actualQty,
                                        )
                                      ]),
                                      buildRow([
                                        'Ordered Qty',
                                        ':',
                                        numberFormat.format(
                                          stateBin.data[0].orderedQty,
                                        )
                                      ]),
                                      buildRow([
                                        'Reserved Qty',
                                        ':',
                                        numberFormat.format(
                                          stateBin.data[0].reservedQty,
                                        )
                                      ]),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Container(
                              padding: const EdgeInsets.only(bottom: 20),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: Get.width * 0.9,
                      height: 255,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: state.data.image != null && state.data.image != ""
                          ? InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) =>
                                      SizedBox(
                                    width: Get.width,
                                    height: Get.height,
                                    child: PhotoView(
                                      imageProvider: NetworkImage(
                                        'https://${state.erpUrl != null && state.erpUrl != "" ? "${state.erpUrl}" : ""}${state.data.image}',
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                'https://${state.erpUrl != null && state.erpUrl != "" ? "${state.erpUrl}" : ""}${state.data.image}',
                              ),
                            )
                          : Image.asset(
                              "assets/images/noimage.jpg",
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  state is ItemIsFailure ? state.error : "No Data",
                  style: const TextStyle(
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
