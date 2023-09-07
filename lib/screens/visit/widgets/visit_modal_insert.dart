// ignore_for_file: unused_local_variable, must_be_immutable, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unused_element, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/screens/visit/checkin_screen.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';

class VisitModalInsert extends StatefulWidget {
  VisitBloc bloc;
  VisitModalInsert({super.key, required this.bloc});

  @override
  State<VisitModalInsert> createState() => _VisitModalInsertState();
}

class _VisitModalInsertState extends State<VisitModalInsert> {
  VisitBloc localBloc = VisitBloc();

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
    } catch (e) {
      print(e);
    }
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
        child: Container(
          width: Get.width * 0.95,
          height: 490,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: BlocBuilder<VisitBloc, VisitState>(
            bloc: localBloc
              ..add(
                VisitGetNaming(),
              ),
            builder: (context, state) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "New Visit",
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
                              endpoint: Endpoint(
                                data: Data.namingSeries,
                                filters: [
                                  ["status", "=", "1"],
                                  ["doc", "=", "visit"]
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
                                localBloc.naming =
                                    KeyValue(name: e["name"], value: e["_id"]);

                                localBloc.emit(
                                  VisitInitial(),
                                );
                              },
                              onReset: () {
                                localBloc.naming =
                                    KeyValue(name: "", value: "");
                                localBloc.emit(
                                  VisitInitial(),
                                );
                              },
                              disabled: false,
                              mandatory: true,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FieldDataScroll(
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
                                localBloc.branch =
                                    KeyValue(name: e["name"], value: e["_id"]);
                                localBloc.group = KeyValue(name: "", value: "");
                                localBloc.customer =
                                    KeyValue(name: "", value: "");
                                localBloc.emit(
                                  VisitInitial(),
                                );
                              },
                              onReset: () {
                                localBloc.branch =
                                    KeyValue(name: "", value: "");
                                localBloc.group = KeyValue(name: "", value: "");
                                localBloc.customer =
                                    KeyValue(name: "", value: "");
                                localBloc.emit(
                                  VisitInitial(),
                                );
                              },
                              mandatory: true,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FieldDataScroll(
                              endpoint: Endpoint(
                                data: Data.customergroup,
                                filters: [
                                  [
                                    "branch._id",
                                    "=",
                                    localBloc.branch?.value != null &&
                                            localBloc.branch?.value != ""
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
                                localBloc.group =
                                    KeyValue(name: e["name"], value: e["_id"]);
                                Get.back();
                                localBloc.emit(
                                  VisitInitial(),
                                );
                              },
                              onReset: () {
                                localBloc.group = KeyValue(name: "", value: "");
                                localBloc.emit(
                                  VisitInitial(),
                                );
                              },
                              mandatory: true,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FieldDataScroll(
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
                                localBloc.customer =
                                    KeyValue(name: e["name"], value: e["_id"]);
                                Get.back();
                                localBloc.emit(
                                  VisitInitial(),
                                );
                              },
                              onReset: () {
                                localBloc.customer =
                                    KeyValue(name: "", value: "");
                                localBloc.emit(
                                  VisitInitial(),
                                );
                              },
                              mandatory: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: Get.width,
                          height: 46,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  (localBloc.naming?.name != null &&
                                          localBloc.group?.name != null &&
                                          localBloc.customer?.name != null)
                                      ? const Color.fromARGB(255, 65, 170, 69)
                                      : const Color.fromARGB(255, 92, 214, 96),
                            ),
                            onPressed: () async {
                              if (localBloc.naming?.name != null &&
                                  localBloc.group?.name != null &&
                                  localBloc.customer?.name != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CheckInScreen(
                                        customerId: localBloc.customer?.value,
                                        bloc: widget.bloc,
                                        naming: localBloc.naming,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              "Check In",
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
    );
  }
}
