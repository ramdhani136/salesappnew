// ignore_for_file: unused_local_variable, must_be_immutable, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unused_element, invalid_use_of_visible_for_testing_member, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/callsheet/callsheet_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';

class CallsheetModalInsert extends StatefulWidget {
  CallsheetBloc bloc;
  CallsheetModalInsert({super.key, required this.bloc});

  @override
  State<CallsheetModalInsert> createState() => _CallsheetModalInsertState();
}

class _CallsheetModalInsertState extends State<CallsheetModalInsert> {
  CallsheetBloc localBloc = CallsheetBloc();
  Future<void> GerDefaultData({
    required Data endpoint,
  }) async {
    try {
      Map<String, dynamic> response = await FetchData(data: endpoint).FINDALL(
        filters: [
          ["status", "=", "1"],
        ],
        fields: ["name"],
      );

      if (response['status'] == 200) {
        List data;
        data = response['data'];

        if (data.length == 1) {
          if (endpoint == Data.branch) {
            localBloc.branch = KeyValue(
              name: data[0]['name'],
              value: data[0]['_id'],
            );
          }
          if (endpoint == Data.customergroup) {
            localBloc.group = KeyValue(
              name: data[0]['name'],
              value: data[0]['_id'],
            );
          }
        }
      }
    } catch (e) {}
  }

  @override
  void initState() {
    GerDefaultData(
      endpoint: Data.branch,
    );
    GerDefaultData(
      endpoint: Data.customergroup,
    );
    super.initState();
  }

  @override
  void dispose() {
    localBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FractionallySizedBox(
        widthFactor: 1.15,
        child: IntrinsicHeight(
          child: Container(
            width: Get.width * 0.98,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: BlocBuilder<CallsheetBloc, CallsheetState>(
              bloc: localBloc
                ..add(
                  CallsheetGetNaming(),
                ),
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "New Callsheet",
                            style: TextStyle(
                              color: Color.fromARGB(255, 66, 66, 66),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldDataScroll(
                                minWidth: Get.width - 116,
                                endpoint: Endpoint(
                                  data: Data.namingSeries,
                                  filters: [
                                    ["status", "=", "1"],
                                    ["doc", "=", "callsheet"]
                                  ],
                                ),
                                valid: localBloc.naming?.value == null ||
                                        localBloc.naming?.value == ""
                                    ? false
                                    : true,
                                value: localBloc.naming?.name ?? "",
                                title: "Naming Series",
                                titleModal: "Naming Series List",
                                onSelected: (e) {
                                  Get.back();
                                  localBloc.naming = KeyValue(
                                      name: e["name"], value: e["_id"]);

                                  localBloc.emit(
                                    CallsheetInitial(),
                                  );
                                },
                                onReset: () {
                                  localBloc.naming =
                                      KeyValue(name: "", value: "");
                                  localBloc.emit(
                                    CallsheetInitial(),
                                  );
                                },
                                disabled: false,
                                mandatory: true,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Type :",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Radio(
                                          activeColor: const Color(0xFFE6212A),
                                          value: "in",
                                          groupValue: localBloc.type,
                                          onChanged: (val) {
                                            localBloc.add(
                                              CallsheetSetForm(
                                                type: val,
                                              ),
                                            );
                                          },
                                        ),
                                        InkWell(
                                            onTap: () {
                                              localBloc.add(
                                                CallsheetSetForm(
                                                  type: "in",
                                                ),
                                              );
                                            },
                                            child: const Text("Incomming Call"))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Radio(
                                          activeColor: const Color(0xFFE6212A),
                                          value: "out",
                                          groupValue: localBloc.type,
                                          onChanged: (val) {
                                            localBloc.add(
                                              CallsheetSetForm(
                                                type: val,
                                              ),
                                            );
                                          },
                                        ),
                                        InkWell(
                                            onTap: () {
                                              localBloc.add(
                                                CallsheetSetForm(
                                                  type: "out",
                                                ),
                                              );
                                            },
                                            child: const Text("Outgoing Call"))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              FieldDataScroll(
                                minWidth: Get.width - 116,
                                endpoint: Endpoint(data: Data.branch),
                                valid: localBloc.branch?.value == null ||
                                        localBloc.branch?.value == ""
                                    ? false
                                    : true,
                                value: localBloc.branch?.name ?? "",
                                title: "Branch",
                                titleModal: "Branch List",
                                onSelected: (e) {
                                  Get.back();
                                  localBloc.branch = KeyValue(
                                      name: e["name"], value: e["_id"]);
                                  localBloc.group =
                                      KeyValue(name: "", value: "");
                                  localBloc.customer =
                                      KeyValue(name: "", value: "");
                                  localBloc.emit(
                                    CallsheetInitial(),
                                  );
                                },
                                onReset: () {
                                  localBloc.branch =
                                      KeyValue(name: "", value: "");
                                  localBloc.group =
                                      KeyValue(name: "", value: "");
                                  localBloc.customer =
                                      KeyValue(name: "", value: "");
                                  localBloc.emit(
                                    CallsheetInitial(),
                                  );
                                },
                                mandatory: true,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Visibility(
                                visible: localBloc.branch != null &&
                                    localBloc.branch?.value != "" &&
                                    localBloc.branch?.value != null,
                                child: Column(
                                  children: [
                                    FieldDataScroll(
                                      minWidth: Get.width - 116,
                                      endpoint: Endpoint(
                                        data: Data.customergroup,
                                        filters: [
                                          [
                                            "branch._id",
                                            "=",
                                            localBloc.branch?.value != null &&
                                                    localBloc.branch?.value !=
                                                        ""
                                                ? localBloc.branch!.value
                                                : "",
                                          ]
                                        ],
                                      ),
                                      valid: localBloc.group?.value == null ||
                                              localBloc.group?.value == ""
                                          ? false
                                          : true,
                                      value: localBloc.group?.name ?? "",
                                      title: "Group",
                                      titleModal: "Group List",
                                      onSelected: (e) {
                                        localBloc.group = KeyValue(
                                            name: e["name"], value: e["_id"]);
                                        localBloc.customer =
                                            KeyValue(name: "", value: "");
                                        Get.back();
                                        localBloc.emit(
                                          CallsheetInitial(),
                                        );
                                      },
                                      onReset: () {
                                        localBloc.group =
                                            KeyValue(name: "", value: "");
                                        localBloc.customer =
                                            KeyValue(name: "", value: "");
                                        localBloc.emit(
                                          CallsheetInitial(),
                                        );
                                      },
                                      mandatory: true,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: localBloc.group != null &&
                                    localBloc.group?.value != "" &&
                                    localBloc.group?.value != null,
                                child: FieldDataScroll(
                                  minWidth: Get.width - 116,
                                  endpoint: Endpoint(
                                    data: Data.customer,
                                    filters: [
                                      [
                                        "customerGroup",
                                        "=",
                                        localBloc.group?.value != null &&
                                                localBloc.group?.value != ""
                                            ? localBloc.group!.value
                                            : "",
                                      ]
                                    ],
                                  ),
                                  valid: localBloc.customer?.value == null ||
                                          localBloc.customer?.value == ""
                                      ? false
                                      : true,
                                  value: localBloc.customer?.name ?? "",
                                  title: "Customer",
                                  titleModal: "Customer List",
                                  onSelected: (e) {
                                    localBloc.customer = KeyValue(
                                        name: e["name"], value: e["_id"]);
                                    Get.back();
                                    localBloc.emit(
                                      CallsheetInitial(),
                                    );
                                  },
                                  onReset: () {
                                    localBloc.customer =
                                        KeyValue(name: "", value: "");
                                    localBloc.emit(
                                      CallsheetInitial(),
                                    );
                                  },
                                  mandatory: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: Get.width,
                            height: 46,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (localBloc.naming?.name !=
                                            null &&
                                        localBloc.group?.name != null &&
                                        localBloc.customer?.name != null)
                                    ? const Color.fromARGB(255, 65, 170, 69)
                                    : const Color.fromARGB(255, 92, 214, 96),
                              ),
                              onPressed: () async {
                                if (localBloc.naming?.name != null &&
                                    localBloc.group?.name != null &&
                                    localBloc.customer?.name != null) {
                                  widget.bloc.add(
                                    CallsheetInsert(
                                      data: {
                                        "namingSeries": localBloc.naming!.value,
                                        "customer": localBloc.customer?.value,
                                        "type": localBloc.type,
                                      },
                                      context: context,
                                      bloc: widget.bloc,
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
