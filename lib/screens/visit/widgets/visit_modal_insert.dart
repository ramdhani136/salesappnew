// ignore_for_file: unused_local_variable, must_be_immutable, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/customer/customer_bloc.dart';
import 'package:salesappnew/bloc/field_infinite/field_infinite_bloc.dart';
import 'package:salesappnew/bloc/group/group_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';

import 'package:salesappnew/models/group_model.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/screens/contact/customer_form_screen.dart';
import 'package:salesappnew/screens/visit/checkin_screen.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:salesappnew/widgets/field_infinite_scroll.dart';

class VisitModalInsert extends StatelessWidget {
  VisitBloc bloc;
  VisitModalInsert({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    VisitBloc thisBloc = VisitBloc();
    GroupBloc groupBloc = GroupBloc()
      ..add(
        GroupGetData(getRefresh: true),
      );
    CustomerBloc customerBloc = CustomerBloc();
    TextEditingController namingC = TextEditingController();
    FieldInfiniteBloc groupFieldBloc = FieldInfiniteBloc();
    FieldInfiniteBloc customerFieldBloc = FieldInfiniteBloc();

    void _onSearchTextChanged(String searchText) {
      if (thisBloc.group != null) {
        customerBloc.add(CustomerChangeSearch(searchText));
        customerBloc.add(
          GetAllCustomer(
            refresh: true,
            search: searchText,
            filters: [
              ["customerGroup", "=", thisBloc.group!.value]
            ],
          ),
        );
      }
    }

    void _GroupOnSearch(String searchText) {
      groupBloc.add(GroupChangeSearch(searchText));
      groupBloc.add(
        GroupGetData(
          getRefresh: true,
          search: searchText,
        ),
      );
    }

    // void _onSearchGroup(String searchText) {
    //   customerBloc.add(CustomerChangeSearch(searchText));
    //   _debounceTimer?.cancel();
    //   _debounceTimer = Timer(
    //     const Duration(milliseconds: 30),
    //     () {
    //       customerBloc.add(
    //         GetAllCustomer(
    //           refresh: true,
    //           search: searchText,
    //           filters: [
    //             ["customerGroup", "=", thisBloc.group!.value]
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // }

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
              if (thisBloc.customer == null) {
                if (bloc.customer != null) {
                  thisBloc.add(
                    VisitSetForm(customer: bloc.customer),
                  );
                }
              }
              if (thisBloc.group == null) {
                if (bloc.group != null) {
                  thisBloc.add(
                    VisitSetForm(group: bloc.group),
                  );
                }
              }

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
                              bloc: groupBloc,
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

                                  groupFieldBloc.add(
                                    FieldInfiniteSetData(
                                      data: data,
                                      pageLoading: stateGroup.pageLoading,
                                      hasMore: stateGroup.hasMore,
                                    ),
                                  );

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

                                if (stateGroup is GroupIsFailure) {
                                  groupFieldBloc.add(
                                    FieldInfiniteSetData(data: const []),
                                  );
                                }

                                if (stateGroup is GroupIsLoading) {
                                  groupFieldBloc.add(
                                    FieldInfiniteSetLoading(loading: true),
                                  );
                                } else {
                                  groupFieldBloc.add(
                                    FieldInfiniteSetLoading(loading: false),
                                  );
                                }

                                return FieldInfiniteScroll(
                                  onScroll: () {
                                    groupBloc.add(
                                      GroupGetData(
                                        getRefresh: false,
                                        search: customerBloc.search,
                                      ),
                                    );
                                  },
                                  controller: TextEditingController(
                                    text: groupBloc.search,
                                  ),
                                  bloc: groupFieldBloc,
                                  onSearch: FieldInfiniteOnSearch(
                                    action: (e) {
                                      _GroupOnSearch(e);
                                    },
                                    // widget: CustomerFormScreen(
                                    //   bloc: customerBloc,
                                    //   group: thisBloc.group,
                                    // ),
                                  ),
                                  onRefresh: () {
                                    groupBloc.add(
                                      GroupGetData(
                                        search: groupBloc.search,
                                      ),
                                    );
                                  },
                                  onTap: () {
                                    groupBloc.add(
                                      GroupGetData(
                                        getRefresh: true,
                                      ),
                                    );
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
                                    bloc.add(
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
                                    bloc.add(
                                      VisitResetForm(
                                        group: true,
                                        customer: true,
                                      ),
                                    );
                                  },
                                  onRefreshReset: () {
                                    thisBloc.search = "";
                                    groupBloc.add(
                                      GroupGetData(
                                        search: "",
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
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                BlocBuilder<CustomerBloc, CustomerState>(
                                  bloc: customerBloc,
                                  builder: (context, stateCust) {
                                    List<FieldInfiniteData> data = [];

                                    if (stateCust is CustomerIsLoaded) {
                                      List<Set<FieldInfiniteData>> nestedData =
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

                                      customerFieldBloc.add(
                                        FieldInfiniteSetData(
                                          data: data,
                                          pageLoading: stateCust.IsloadingPage,
                                          hasMore: stateCust.hasMore,
                                        ),
                                      );
                                    }
                                    if (stateCust is CustomerIsFailure) {
                                      customerFieldBloc.add(
                                        FieldInfiniteSetData(data: const []),
                                      );
                                    }

                                    if (stateCust is CustomerIsLoading) {
                                      customerFieldBloc.add(
                                        FieldInfiniteSetLoading(loading: true),
                                      );
                                    } else {
                                      customerFieldBloc.add(
                                        FieldInfiniteSetLoading(loading: false),
                                      );
                                    }

                                    return FieldInfiniteScroll(
                                      onScroll: () {
                                        customerBloc.add(
                                          GetAllCustomer(
                                            refresh: false,
                                            filters: [
                                              [
                                                "customerGroup",
                                                "=",
                                                thisBloc.group?.value ?? ""
                                              ]
                                            ],
                                            search: customerBloc.search,
                                          ),
                                        );
                                      },
                                      controller: TextEditingController(
                                        text: customerBloc.search,
                                      ),
                                      bloc: customerFieldBloc,
                                      onSearch: FieldInfiniteOnSearch(
                                        action: (e) {
                                          _onSearchTextChanged(e);
                                        },
                                        widget: CustomerFormScreen(
                                          bloc: customerBloc,
                                          group: thisBloc.group,
                                        ),
                                      ),
                                      disabled: thisBloc.group == null,
                                      onRefresh: () {
                                        customerBloc.add(
                                          GetAllCustomer(
                                            filters: [
                                              [
                                                "customerGroup",
                                                "=",
                                                thisBloc.group?.value ?? ""
                                              ]
                                            ],
                                            search: customerBloc.search,
                                          ),
                                        );
                                      },
                                      onTap: () {
                                        if (thisBloc.group != null) {
                                          customerBloc.add(
                                            GetAllCustomer(
                                              filters: [
                                                [
                                                  "customerGroup",
                                                  "=",
                                                  thisBloc.group?.value ?? ""
                                                ]
                                              ],
                                              search: customerBloc.search,
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
                                      onRefreshReset: () {
                                        thisBloc.search = "";
                                        customerBloc.add(
                                          GetAllCustomer(
                                            filters: [
                                              [
                                                "customerGroup",
                                                "=",
                                                thisBloc.group?.value ?? ""
                                              ]
                                            ],
                                            search: "",
                                          ),
                                        );
                                      },
                                      placeholder: "Select Customer",
                                      value: thisBloc.customer?.name ?? "",
                                      title: "Customer",
                                      titleModal: "Customer List ",
                                      mandatory: true,
                                      valid: thisBloc.customer?.name != null
                                          ? true
                                          : false,
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: Get.width,
                          height: 46,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (thisBloc.naming?.name != null &&
                                      thisBloc.group?.name != null &&
                                      thisBloc.customer?.name != null)
                                  ? const Color.fromARGB(255, 65, 170, 69)
                                  : const Color.fromARGB(255, 92, 214, 96),
                            ),
                            onPressed: () async {
                              if (thisBloc.naming?.name != null &&
                                  thisBloc.group?.name != null &&
                                  thisBloc.customer?.name != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CheckInScreen(
                                        customerId: thisBloc.customer?.value,
                                        bloc: bloc,
                                        naming: thisBloc.naming,
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
