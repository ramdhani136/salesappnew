// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously
// ignore_for_file: must_be_immutable
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:salesappnew/utils/fetch_data.dart';

class Endpoint {
  Data data;
  int? page;
  int? limit;
  List<List<String>>? filters;
  Endpoint({
    required this.data,
    this.page,
    this.limit,
    this.filters,
  });
}

class FieldDataScroll extends StatefulWidget {
  String? placeholder;
  bool resetOpenModal;
  bool valid;
  String? title;
  String? titleModal;
  bool disabled;
  double? minWidth;
  Function onSelected;
  bool textArea;
  final void Function(String e)? onChange;
  Function? onReset;
  Function? onTap;
  bool mandatory;
  Function? InsertAction;
  String value;
  Endpoint endpoint;
  Widget? ComponentInsert;

  FieldDataScroll({
    this.onChange,
    this.resetOpenModal = true,
    required this.value,
    this.textArea = false,
    this.disabled = false,
    required this.onSelected,
    this.InsertAction,
    this.minWidth,
    this.onReset,
    this.onTap,
    this.placeholder,
    this.title,
    this.titleModal,
    this.valid = true,
    this.mandatory = false,
    required this.endpoint,
    this.ComponentInsert,
    super.key,
  });

  @override
  State<FieldDataScroll> createState() => _FieldDataScrollState();
}

class _FieldDataScrollState extends State<FieldDataScroll> {
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
              showDialog(
                context: context,
                builder: (context) => ModalField(
                  titleModal: widget.titleModal ?? "",
                  onSelected: widget.onSelected,
                  enpoint: widget.endpoint,
                  ComponentInsert: widget.ComponentInsert,
                  onChange: widget.onChange,
                ),
              );

              if (widget.onTap != null) {
                widget.onTap!();
              }
            }
          },
          child: Container(
              width: Get.width * 0.95,
              height: widget.disabled
                  ? 50
                  : widget.textArea
                      ? 40
                      : 46,
              decoration: BoxDecoration(
                color: widget.textArea || widget.disabled
                    ? Colors.transparent
                    : Colors.white,
                border: widget.disabled
                    ? const Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 193, 193, 193),
                        ),
                        // borderRadius: BorderRadius.circular(4),
                      )
                    : Border.all(
                        color: widget.textArea
                            ? Colors.transparent
                            : !widget.disabled
                                ? widget.valid
                                    ? const Color.fromARGB(255, 182, 182, 182)
                                    : Colors.red
                                : const Color.fromARGB(255, 182, 182, 182),
                        width: 1.0,
                      ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          minWidth: widget.minWidth != null
                              ? widget.minWidth!
                              : Get.width - 81),
                      child: Row(
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
                    ),
                    Visibility(
                      visible: !widget.disabled && widget.value != "",
                      child: IconButton(
                        onPressed: () async {
                          if (!widget.disabled) {
                            if (widget.resetOpenModal) {
                              showDialog(
                                context: context,
                                builder: (context) => ModalField(
                                  titleModal: widget.titleModal ?? "",
                                  onSelected: widget.onSelected,
                                  enpoint: widget.endpoint,
                                  onChange: widget.onChange,
                                  ComponentInsert: widget.ComponentInsert,
                                ),
                              );
                            }

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
                ),
              )),
        )
      ],
    );
  }
}

class ModalField extends StatefulWidget {
  String titleModal;
  bool disabled;
  String placeholderModal;
  Function onSelected;
  Endpoint enpoint;
  Widget? ComponentInsert;
  final void Function(String e)? onChange;

  ModalField({
    Key? key,
    this.onChange,
    this.titleModal = "",
    this.disabled = false,
    this.placeholderModal = "",
    required this.onSelected,
    required this.enpoint,
    this.ComponentInsert,
  }) : super(key: key);

  @override
  State<ModalField> createState() => _ModalFieldState();
}

class _ModalFieldState extends State<ModalField> {
  List<dynamic> data = [];
  int page = 1;
  bool hasMore = false;
  Timer? debounceTimer;
  TextEditingController controller = TextEditingController();
  bool loading = true;
  bool pageLoading = false;
  String search = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showCustomModal(BuildContext context) {
    if (widget.ComponentInsert != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(0),
            child: Container(
              width: Get.width - 30,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.ComponentInsert != null
                      ? [
                          widget.ComponentInsert!,
                        ]
                      : [],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> getData({bool refresh = true}) async {
    try {
      if (refresh) {
        await EasyLoading.show(status: 'loading...');
        setState(() {
          page = 1;
          hasMore = false;
          loading = true;
        });
      }
      List<List<String>> finalFilter = [
        ["status", "=", "1"]
      ];

      if (widget.enpoint.filters != null) {
        finalFilter.addAll(widget.enpoint.filters!);
      }
      Map<String, dynamic> response =
          await FetchData(data: widget.enpoint.data).FINDALL(
        limit: 20,
        filters: finalFilter,
        page: page,
        search: search,
      );

      if (response['status'] != 200) {
        throw response['msg'];
      }

      List<dynamic> currentData = [];
      if (refresh) {
        currentData = response['data'];
      } else {
        currentData = data;
        currentData.addAll(response['data']);
      }

      setState(() {
        data = currentData;
        page = response['nextPage'];
        hasMore = response['hasMore'];
        pageLoading = false;
        loading = false;
      });
    } catch (e) {
      if (refresh) {
        setState(() {
          data = [];
        });
      }
      setState(() {
        hasMore = false;
        pageLoading = false;
        loading = false;
      });
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
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
                        widget.titleModal,
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
                      debounceTimer?.cancel();
                      debounceTimer = Timer(
                        const Duration(milliseconds: 40),
                        () {
                          if (widget.onChange != null) {
                            widget.onChange!(e);
                          }
                          setState(() {
                            page = 1;
                            hasMore = false;
                            search = e;
                          });
                          getData(refresh: true);
                        },
                      );
                    },
                    controller: controller,
                    autocorrect: false,
                    enableSuggestions: false,
                    autofocus: true,
                    decoration: InputDecoration(
                      suffixIcon: Visibility(
                        visible: !widget.disabled,
                        child: IconButton(
                          onPressed: () async {
                            if (!widget.disabled) {
                              controller.text = "";
                              setState(() {
                                search = "";
                              });
                              getData();
                            }
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      hintText: widget.placeholderModal,
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
                          setState(() {
                            hasMore = false;
                            pageLoading = true;
                          });
                          getData(refresh: false);
                        }
                        return false;
                      },
                      child: RefreshIndicator(
                        onRefresh: () async {
                          getData(refresh: true);
                        },
                        child: Column(
                          children: [
                            Visibility(
                              visible: data.isEmpty && !loading,
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
                                        visible: data.isEmpty &&
                                            widget.ComponentInsert != null,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            showCustomModal(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color
                                                .fromARGB(255, 57, 156,
                                                60), // Mengatur warna latar belakang
                                          ),
                                          child: const Text(
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
                              visible: data.isNotEmpty && !loading,
                              child: Expanded(
                                child: Stack(
                                  children: [
                                    ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            controller.text =
                                                data[index]['name']!;
                                            widget.onSelected(data[index]);
                                            // Get.back();
                                          },
                                          title: Text("${data[index]['name']}"),
                                        );
                                      },
                                    ),
                                    Visibility(
                                      visible: pageLoading,
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
