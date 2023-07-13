// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/customer/customer_bloc.dart';
import 'package:salesappnew/bloc/group/group_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';

import 'package:salesappnew/models/group_model.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/screens/visit/checkin_screen.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:salesappnew/widgets/field_infinite_scroll.dart';

class VisitModalInsert extends StatelessWidget {
  VisitBloc bloc;
  VisitModalInsert({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    VisitBloc thisBloc = VisitBloc();
    GroupBloc groupBloc = GroupBloc();
    CustomerBloc customerBloc = CustomerBloc();
    TextEditingController namingC = TextEditingController();

    return Dialog(
      child: FractionallySizedBox(
        widthFactor: 1.15,
        child: Container(
          width: Get.width * 0.95,
          height: 440,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: BlocBuilder<VisitBloc, VisitState>(
            bloc: thisBloc
              ..add(
                VisitGetNaming(),
              ),
            builder: (context, state) {
              namingC.text = thisBloc.naming?.name ?? "";

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
                            Column(
                              children: [
                                CustomField(
                                  placeholder: "Cth : VST2020MMDD",
                                  mandatory: true,
                                  // disabled: state.data.status != "0",
                                  title: "Naming Series",
                                  controller: namingC,
                                  valid: thisBloc.naming?.value != null,
                                  type: Type.select,
                                  data: thisBloc.namingList ?? [],
                                  onChange: (e) {
                                    thisBloc.add(
                                      VisitSetForm(
                                        naming: KeyValue(
                                          name: e['title'],
                                          value: e['value'],
                                        ),
                                      ),
                                    );
                                  },
                                  onReset: () {
                                    thisBloc.add(
                                      VisitResetForm(naming: true),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                            BlocBuilder<GroupBloc, GroupState>(
                              bloc: groupBloc
                                ..add(
                                  GroupGetData(getRefresh: true),
                                ),
                              builder: (context, stateGroup) {
                                List<FieldInfiniteData> data = [];
                                if (stateGroup is GroupIsLoaded) {
                                  List<Set<FieldInfiniteData>> nestedData =
                                      stateGroup.data.map((item) {
                                    return {
                                      FieldInfiniteData(
                                          title: item.name!, value: item)
                                    };
                                  }).toList();

                                  data =
                                      nestedData.expand((set) => set).toList();

                                  if (data.length == 1) {
                                    thisBloc.add(
                                      VisitSetForm(
                                        group: KeyValue(
                                          name: data[0].value.name,
                                          value: data[0].value.id,
                                        ),
                                      ),
                                    );
                                  }
                                }

                                return FieldInfiniteScroll(
                                  data: data,
                                  onTap: () {
                                    groupBloc
                                        .add(GroupGetData(getRefresh: true));
                                  },
                                  onChange: (GroupModel e) {
                                    thisBloc.add(
                                      VisitSetForm(
                                        group: KeyValue(
                                          name: e.name.toString(),
                                          value: e.id,
                                        ),
                                      ),
                                    );
                                    thisBloc.add(
                                      VisitResetForm(
                                        customer: true,
                                      ),
                                    );
                                  },
                                  onReset: () {
                                    thisBloc.add(
                                      VisitResetForm(
                                        group: true,
                                        customer: true,
                                      ),
                                    );
                                  },
                                  placeholder: "Select Group",
                                  value: thisBloc.group?.name ?? "",
                                  title: "Group",
                                  titleModal: "Group List",
                                  mandatory: true,
                                  valid: thisBloc.group?.name != null
                                      ? true
                                      : false,
                                );
                              },
                            ),
                            Visibility(
                              visible: thisBloc.group != null,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  BlocBuilder<CustomerBloc, CustomerState>(
                                    bloc: customerBloc
                                      ..add(
                                        GetAllCustomer(
                                          refresh: true,
                                          filters: [
                                            [
                                              "customerGroup",
                                              "=",
                                              thisBloc.group?.value ?? ""
                                            ]
                                          ],
                                        ),
                                      ),
                                    builder: (context, stateCust) {
                                      List<FieldInfiniteData> data = [];

                                      if (stateCust is CustomerIsLoaded) {
                                        List<Set<FieldInfiniteData>>
                                            nestedData =
                                            stateCust.data.map((item) {
                                          return {
                                            FieldInfiniteData(
                                              title: item['name'],
                                              value: item,
                                            )
                                          };
                                        }).toList();

                                        data = nestedData
                                            .expand((set) => set)
                                            .toList();
                                      }

                                      return FieldInfiniteScroll(
                                        data: data,
                                        onTap: () {
                                          if (thisBloc.group != null) {
                                            customerBloc.add(
                                              GetAllCustomer(
                                                refresh: true,
                                                filters: [
                                                  [
                                                    "customerGroup",
                                                    "=",
                                                    thisBloc.group?.value ?? ""
                                                  ]
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        onChange: (e) {
                                          thisBloc.add(
                                            VisitSetForm(
                                              customer: KeyValue(
                                                name: e['name'].toString(),
                                                value: e['_id'],
                                              ),
                                            ),
                                          );
                                        },
                                        onReset: () {
                                          thisBloc.add(
                                            VisitResetForm(customer: true),
                                          );
                                        },
                                        placeholder: "Select Customer",
                                        value: thisBloc.customer?.name ?? "",
                                        title: "Customer",
                                        titleModal: "Customer List",
                                        mandatory: true,
                                        valid: thisBloc.customer?.name != null
                                            ? true
                                            : false,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: Get.width,
                          height: 46,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 65, 170, 69),
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CheckInScreen(
                                      customerId: thisBloc.customer?.value,
                                    );
                                  },
                                ),
                              );
                              print(thisBloc.naming?.name);
                              print(thisBloc.group?.name);
                              print(thisBloc.customer?.name);
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
