// ignore_for_file: unused_local_variable, must_be_immutable, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unused_element, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/screens/visit/checkin_screen.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';

class VisitModalInsert extends StatelessWidget {
  VisitBloc bloc;
  VisitModalInsert({super.key, required this.bloc});

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
            bloc: bloc
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
                              valid: bloc.naming?.value == null ||
                                      bloc.naming?.value == ""
                                  ? false
                                  : true,
                              value: bloc.naming?.name ?? "",
                              title: "Naming Series",
                              titleModal: "Naming Series List",
                              onSelected: (e) {
                                Get.back();
                                bloc.naming =
                                    KeyValue(name: e["name"], value: e["_id"]);

                                bloc.emit(
                                  VisitInitial(),
                                );
                              },
                              onReset: () {
                                bloc.naming = KeyValue(name: "", value: "");
                                bloc.emit(
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
                              valid: bloc.branch?.value == null ||
                                      bloc.branch?.value == ""
                                  ? false
                                  : true,
                              value: bloc.branch?.name ?? "",
                              title: "Branch",
                              titleModal: "Branch List",
                              onSelected: (e) {
                                Get.back();
                                bloc.branch =
                                    KeyValue(name: e["name"], value: e["_id"]);
                                bloc.group = KeyValue(name: "", value: "");
                                bloc.customer = KeyValue(name: "", value: "");
                                bloc.emit(
                                  VisitInitial(),
                                );
                              },
                              onReset: () {
                                bloc.branch = KeyValue(name: "", value: "");
                                bloc.group = KeyValue(name: "", value: "");
                                bloc.customer = KeyValue(name: "", value: "");
                                bloc.emit(
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
                                    bloc.branch?.value != null &&
                                            bloc.branch?.value != ""
                                        ? bloc.branch!.value
                                        : "",
                                  ]
                                ],
                              ),
                              valid: bloc.group?.value == null ||
                                      bloc.group?.value == ""
                                  ? false
                                  : true,
                              value: bloc.group?.name ?? "",
                              title: "Group",
                              titleModal: "Group List",
                              onSelected: (e) {
                                bloc.group =
                                    KeyValue(name: e["name"], value: e["_id"]);
                                Get.back();
                                bloc.emit(
                                  VisitInitial(),
                                );
                              },
                              onReset: () {
                                bloc.group = KeyValue(name: "", value: "");
                                bloc.emit(
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
                                    bloc.group?.value != null &&
                                            bloc.group?.value != ""
                                        ? bloc.group!.value
                                        : "",
                                  ]
                                ],
                              ),
                              valid: bloc.customer?.value == null ||
                                      bloc.customer?.value == ""
                                  ? false
                                  : true,
                              value: bloc.customer?.name ?? "",
                              title: "Customer",
                              titleModal: "Customer List",
                              onSelected: (e) {
                                bloc.customer =
                                    KeyValue(name: e["name"], value: e["_id"]);
                                Get.back();
                                bloc.emit(
                                  VisitInitial(),
                                );
                              },
                              onReset: () {
                                bloc.customer = KeyValue(name: "", value: "");
                                bloc.emit(
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
                              backgroundColor: (bloc.naming?.name != null &&
                                      bloc.group?.name != null &&
                                      bloc.customer?.name != null)
                                  ? const Color.fromARGB(255, 65, 170, 69)
                                  : const Color.fromARGB(255, 92, 214, 96),
                            ),
                            onPressed: () async {
                              if (bloc.naming?.name != null &&
                                  bloc.group?.name != null &&
                                  bloc.customer?.name != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CheckInScreen(
                                        customerId: bloc.customer?.value,
                                        bloc: bloc,
                                        naming: bloc.naming,
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
