// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously
// ignore_for_file: must_be_immutable
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesappnew/models/customer_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

class FieldDataScroll extends StatefulWidget {
  String? placeholder;
  bool valid;
  String? title;
  Function? onRefreshReset;
  String? titleModal;
  bool disabled;
  Function? onChange;
  Function? onScroll;
  Function? onReset;
  Function? onTap;
  Function? onRefresh;
  bool mandatory;
  Function? InsertAction;
  String value;
  FieldInfiniteOnSearch? onSearch;
  TextEditingController? controller;
  FieldDataScroll({
    required this.value,
    this.controller,
    this.disabled = false,
    this.onChange,
    this.onRefresh,
    this.onRefreshReset,
    this.InsertAction,
    this.onScroll,
    this.onSearch,
    this.onReset,
    this.onTap,
    this.placeholder,
    this.title,
    this.titleModal,
    this.valid = true,
    this.mandatory = false,
    super.key,
  });

  @override
  State<FieldDataScroll> createState() => _FieldDataScrollState();
}

class _FieldDataScrollState extends State<FieldDataScroll> {
  String? placeholderModal;
  List<CustomerModel> data = [];
  bool hasMore = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getData({bool refresh = true}) async {
    try {
      Map<String, dynamic> response =
          await FetchData(data: Data.customer).FINDALL(
        limit: 10,
        filters: [
          ["status", "=", "1"]
        ],
        page: page,
      );

      List<CustomerModel> isData = CustomerModel.fromJsonList(response['data']);

      List<CustomerModel> currentData = [];
      if (refresh) {
        currentData = data;
        currentData.addAll(isData);
      } else {
        currentData = isData;
      }
      setState(() {
        data = currentData;
        page = response['nextPage'];
        hasMore = response['hasMore'];
      });
    } catch (e) {
      setState(() {
        hasMore = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.title != null,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${widget.title}",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Visibility(
                        visible: widget.mandatory && !widget.disabled,
                        child: const Text(
                          "*",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.InsertAction != null && !widget.disabled,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                      ),
                      onPressed: () async {
                        if (!widget.disabled && widget.InsertAction != null) {
                          widget.InsertAction!();
                        }
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text("New"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            if (!widget.disabled) {
              await getData();
              showDialog(
                context: context,
                builder: (context) => FieldInfiniteModal(
                    customer: data, hasMore: hasMore, page: page),
              );
            }
          },
          child: Container(
              width: Get.width * 0.95,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: !widget.disabled
                      ? widget.valid
                          ? const Color.fromARGB(255, 182, 182, 182)
                          : Colors.red
                      : const Color.fromARGB(255, 182, 182, 182),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.value == ""
                            ? widget.placeholder ?? widget.value
                            : widget.value,
                        style: TextStyle(
                          color: widget.value == ""
                              ? Colors.grey[300]
                              : widget.disabled
                                  ? Colors.grey[800]
                                  : Colors.grey[900],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !widget.disabled,
                    child: IconButton(
                      onPressed: () {
                        if (!widget.disabled) {
                          if (widget.onReset != null) {
                            widget.onReset!();
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      iconSize: 20,
                    ),
                  ),
                ],
              )),
        )
      ],
    );
  }

  Widget FieldInfiniteModal(
      {required List<CustomerModel> customer,
      required int page,
      required bool hasMore}) {
    Timer? debounceTimer;

    void _showCustomModal(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(0),
            child: Container(
              width: Get.width - 50,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.onSearch!.widget!,
                ],
              ),
            ),
          );
        },
      );
    }

    return Dialog(
      child: FractionallySizedBox(
        widthFactor: 1.2,
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.titleModal ?? "",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 66, 66, 66),
                          fontWeight: FontWeight.bold,
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
                  TextField(
                    onChanged: (e) {
                      if (widget.onSearch != null) {
                        debounceTimer?.cancel();
                        debounceTimer = Timer(
                          const Duration(milliseconds: 40),
                          () {
                            widget.onSearch!.action(e);
                          },
                        );
                      }
                    },
                    controller: widget.controller ?? TextEditingController(),
                    autocorrect: false,
                    enableSuggestions: false,
                    autofocus: true,
                    decoration: InputDecoration(
                      suffixIcon: Visibility(
                        visible: !widget.disabled,
                        child: IconButton(
                          onPressed: () async {
                            if (!widget.disabled) {
                              if (widget.controller != null) {
                                widget.controller!.text = "";
                                if (widget.onRefreshReset != null) {
                                  widget.onRefreshReset!();
                                }
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      hintText: placeholderModal ?? "Search",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                            hasMore) {
                          getData();
                          // bloc.add(
                          //   FieldInfiniteSetData(
                          //     hasMore: false,
                          //   ),
                          // );
                          // if (onScroll != null) {
                          //   onScroll!();
                          // }
                        }
                        return false;
                      },
                      child: RefreshIndicator(
                        onRefresh: () async {
                          if (widget.onRefresh != null) {
                            widget.onRefresh!();
                          }
                        },
                        child: Column(
                          children: [
                            Visibility(
                              visible: false,
                              child: Expanded(child: Container()),
                            ),
                            Visibility(
                              visible: false,
                              child: Expanded(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Data not found",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Visibility(
                                        visible:
                                            widget.onSearch?.widget != null,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (widget.onSearch?.widget !=
                                                null) {
                                              _showCustomModal(context);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color
                                                    .fromARGB(255, 57, 156,
                                                60), // Mengatur warna latar belakang
                                          ),
                                          child: Text(
                                            widget.onSearch?.label ??
                                                "Create New",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Expanded(
                                child: Stack(
                                  children: [
                                    ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                            onTap: () {
                                              if (widget.onChange != null) {
                                                widget.controller!.text =
                                                    data[index].name!;
                                                widget.onChange!(data[index]);
                                              }
                                              Get.back();
                                            },
                                            title: Text("${data[index].name}"));
                                      },
                                    ),
                                    Visibility(
                                      visible: false,
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class FieldInfiniteData {
  String title;
  String? subTitle;
  dynamic value;
  FieldInfiniteData({required this.title, required this.value, this.subTitle});
}

class FieldInfiniteOnSearch {
  Function action;
  Widget? widget;
  String? label;
  String? titleWidget;
  FieldInfiniteOnSearch({
    required this.action,
    this.label,
    this.titleWidget,
    this.widget,
  });
}
