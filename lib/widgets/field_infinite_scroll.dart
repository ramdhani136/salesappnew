// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers
// ignore_for_file: must_be_immutable
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:salesappnew/bloc/field_infinite/field_infinite_bloc.dart';

class FieldInfiniteScroll extends StatelessWidget {
  String? placeholder;
  String? placeholderModal;
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
  FieldInfiniteBloc bloc;
  String value;
  FieldInfiniteOnSearch? onSearch;
  TextEditingController? controller;
  FieldInfiniteScroll({
    required this.value,
    required this.bloc,
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
  Widget build(BuildContext context) {
    return BlocBuilder<FieldInfiniteBloc, FieldInfiniteState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: [
              Visibility(
                visible: title != null,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "$title",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Visibility(
                              visible: mandatory && !disabled,
                              child: const Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: InsertAction != null && !disabled,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 49, 49, 49),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                            ),
                            onPressed: () async {
                              if (!disabled && InsertAction != null) {
                                InsertAction!();
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
                onTap: () {
                  if (!disabled) {
                    if (onTap != null) {
                      onTap!();
                    }

                    showDialog(
                      context: context,
                      builder: (context) => FieldInfiniteModal(),
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
                        color: !disabled
                            ? valid
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
                              value == "" ? placeholder ?? value : value,
                              style: TextStyle(
                                color: value == ""
                                    ? Colors.grey[300]
                                    : disabled
                                        ? Colors.grey[800]
                                        : Colors.grey[900],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: !disabled,
                          child: IconButton(
                            onPressed: () {
                              if (!disabled) {
                                if (onReset != null) {
                                  onReset!();
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
        });
  }

  Widget FieldInfiniteModal() {
    Timer? debounceTimer;

    void _showCustomModal(BuildContext context) {
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  onSearch!.widget!,
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
            child: BlocBuilder<FieldInfiniteBloc, FieldInfiniteState>(
                bloc: bloc,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            titleModal ?? "",
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
                          if (onSearch != null) {
                            debounceTimer?.cancel();
                            debounceTimer = Timer(
                              const Duration(seconds: 1),
                              () {
                                onSearch!.action(e);
                              },
                            );
                          }
                        },
                        controller: controller ?? TextEditingController(),
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          suffixIcon: Visibility(
                            visible: !disabled,
                            child: IconButton(
                              onPressed: () async {
                                if (!disabled) {
                                  if (controller != null) {
                                    controller!.text = "";
                                    if (onRefreshReset != null) {
                                      onRefreshReset!();
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
                              color:
                                  Colors.blue, // Warna border yang diinginkan
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
                                bloc.hasMore) {
                              bloc.add(
                                FieldInfiniteSetData(
                                  hasMore: false,
                                ),
                              );
                              if (onScroll != null) {
                                onScroll!();
                              }
                            }
                            return false;
                          },
                          child: RefreshIndicator(
                            onRefresh: () async {
                              if (onRefresh != null) {
                                onRefresh!();
                              }
                            },
                            child: Column(
                              children: [
                                Visibility(
                                  visible: bloc.isLoading,
                                  child: Expanded(child: Container()),
                                ),
                                Visibility(
                                  visible: bloc.data.isEmpty && !bloc.isLoading,
                                  child: Expanded(
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            visible: onSearch?.widget != null,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (onSearch?.widget != null) {
                                                  _showCustomModal(context);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color
                                                        .fromARGB(255, 57, 156,
                                                    60), // Mengatur warna latar belakang
                                              ),
                                              child: Text(
                                                onSearch?.label ?? "Create New",
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !bloc.isLoading,
                                  child: Expanded(
                                    child: Stack(
                                      children: [
                                        ListView.builder(
                                          itemCount: bloc.data.length,
                                          itemBuilder: (context, index) {
                                            if (bloc.data[index].subTitle !=
                                                null) {
                                              return ListTile(
                                                onTap: () {
                                                  if (onChange != null) {
                                                    onChange!(
                                                        bloc.data[index].value);
                                                  }
                                                  Get.back();
                                                },
                                                title: Text(
                                                    bloc.data[index].title),
                                                subtitle: Text(
                                                    bloc.data[index].subTitle!),
                                              );
                                            } else {
                                              return ListTile(
                                                onTap: () {
                                                  if (onChange != null) {
                                                    onChange!(
                                                        bloc.data[index].value);
                                                  }
                                                  Get.back();
                                                },
                                                title: Text(
                                                    bloc.data[index].title),
                                              );
                                            }
                                          },
                                        ),
                                        Visibility(
                                          visible: bloc.pageLoading,
                                          child: const Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: SizedBox(
                                                width: 10,
                                                height: 10,
                                                child:
                                                    CircularProgressIndicator(
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
                  );
                }),
          ),
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
