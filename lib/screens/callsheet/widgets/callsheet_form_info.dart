// ignore_for_file: unused_local_variable, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/bloc/callsheet/callsheet_bloc.dart';
import 'package:salesappnew/bloc/contact/contact_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/screens/callsheet/widgets/customer_form_widget.dart';
import 'package:salesappnew/screens/contact/contact_form_screen.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CallsheetFormInfo extends StatefulWidget {
  const CallsheetFormInfo({
    super.key,
  });

  @override
  State<CallsheetFormInfo> createState() => _CallsheetFormInfoState();
}

class _CallsheetFormInfoState extends State<CallsheetFormInfo> {
  TextEditingController typeC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController workflowC = TextEditingController();
  TextEditingController picC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController positionC = TextEditingController();
  CallsheetBloc localBloc = CallsheetBloc();

  @override
  void dispose() {
    super.dispose();
    typeC.dispose();
    nameC.dispose();
    workflowC.dispose();
    picC.dispose();
    phoneC.dispose();
    dateC.dispose();
    positionC.dispose();
    localBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final PanelController panelController = PanelController();
    CallsheetBloc bloc = BlocProvider.of<CallsheetBloc>(context);

    return BlocBuilder<CallsheetBloc, CallsheetState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is CallsheetIsFailure) {
          Center(
            child: Text(state.error),
          );
        }

        if (state is CallsheetIsShowLoaded) {
          localBloc.branch = bloc.branch;
          localBloc.group = bloc.group;
          localBloc.customer = bloc.customer;
          typeC.text = state.data.type!;
          nameC.text = state.data.name!;
          workflowC.text = state.data.workflowState!;
          if (state.data.contact != null) {
            localBloc.contact = KeyValue(
                name: state.data.contact!.name!, value: state.data.contact!.id);
          } else {
            localBloc.contact = null;
          }
          picC.text =
              state.data.contact != null ? state.data.contact!.name! : "";
          positionC.text =
              state.data.contact != null ? state.data.contact!.position! : "";
          phoneC.text =
              state.data.contact != null ? "${state.data.contact!.phone}" : "";
          dateC.text = DateFormat.yMd().add_jm().format(
                DateTime.parse("${state.data.updatedAt}").toLocal(),
              );

          return Scaffold(
            body: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    bloc.add(CallsheetShowData(id: "${state.data.id}"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 30,
                    ),
                    child: ListView(
                      children: [
                        CustomField(
                          title: "Name",
                          controller: nameC,
                          type: Type.standard,
                          disabled: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomField(
                          title: "Update At",
                          controller: dateC,
                          type: Type.standard,
                          disabled: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<CallsheetBloc, CallsheetState>(
                          bloc: localBloc,
                          builder: (context, stateLocal) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                            value: "in",
                                            groupValue: localBloc.type,
                                            onChanged: (val) {
                                              if (state.data.status == "0") {
                                                localBloc.type = val ?? "";
                                                localBloc.emit(
                                                  CallsheetInitial(),
                                                );
                                              }
                                            },
                                          ),
                                          const Text("Incomming Call")
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: "out",
                                            groupValue: localBloc.type,
                                            onChanged: (val) {
                                              if (state.data.status == "0") {
                                                localBloc.type = val ?? "";
                                                localBloc.emit(
                                                  CallsheetInitial(),
                                                );
                                              }
                                            },
                                          ),
                                          const Text("Outgoing Call")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                FieldDataScroll(
                                    mandatory: true,
                                    endpoint: Endpoint(data: Data.branch),
                                    valid: localBloc.branch?.value == null ||
                                            localBloc.branch?.value == ""
                                        ? false
                                        : true,
                                    value: localBloc.branch?.name ?? "",
                                    title: "Branch",
                                    titleModal: "Branch List",
                                    onSelected: (e) {
                                      localBloc.add(
                                        CallsheetSetForm(
                                          branch: KeyValue(
                                              name: e['name'], value: e['_id']),
                                        ),
                                      );
                                      localBloc.add(
                                        CallsheetResetForm(
                                          customer: true,
                                          group: true,
                                          contact: true,
                                        ),
                                      );
                                      picC.text = "";
                                      phoneC.text = "";
                                      Get.back();
                                    },
                                    onReset: () {
                                      localBloc.add(
                                        CallsheetResetForm(
                                          branch: true,
                                          customer: true,
                                          group: true,
                                          contact: true,
                                        ),
                                      );
                                      picC.text = "";
                                      phoneC.text = "";
                                    },
                                    disabled: state.data.status != "0"),
                                const SizedBox(
                                  height: 15,
                                ),
                                Visibility(
                                  visible: localBloc.branch?.value != null &&
                                      localBloc.branch?.value != "",
                                  child: Column(
                                    children: [
                                      FieldDataScroll(
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
                                          localBloc.add(
                                            CallsheetSetForm(
                                              group: KeyValue(
                                                  name: e['name'],
                                                  value: e['_id']),
                                            ),
                                          );

                                          localBloc.add(
                                            CallsheetResetForm(
                                              customer: true,
                                              contact: true,
                                            ),
                                          );
                                          picC.text = "";
                                          phoneC.text = "";
                                          Get.back();
                                        },
                                        onReset: () {
                                          localBloc.add(
                                            CallsheetResetForm(
                                                customer: true,
                                                group: true,
                                                contact: true),
                                          );
                                          picC.text = "";
                                          phoneC.text = "";
                                        },
                                        mandatory: true,
                                        disabled: state.data.status != "0",
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: localBloc.group?.value != null &&
                                      localBloc.group?.value != "",
                                  child: Column(
                                    children: [
                                      FieldDataScroll(
                                        ComponentInsert: CustomerFormWidget(
                                          branch: localBloc.branch,
                                          group: localBloc.group,
                                          onSuccess: (e) {
                                            localBloc.add(
                                              CallsheetSetForm(
                                                customer: KeyValue(
                                                  name: e['name'],
                                                  value: e['_id'],
                                                ),
                                                group: KeyValue(
                                                  name: e['customerGroup']
                                                      ['name'],
                                                  value: e['customerGroup']
                                                      ['_id'],
                                                ),
                                                branch: KeyValue(
                                                  name: e['branch']['name'],
                                                  value: e['branch']['_id'],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        endpoint: Endpoint(
                                          data: Data.customer,
                                          filters: [
                                            [
                                              "customerGroup",
                                              "=",
                                              localBloc.group?.value != null &&
                                                      localBloc.group?.value !=
                                                          ""
                                                  ? localBloc.group!.value
                                                  : "",
                                            ]
                                          ],
                                        ),
                                        valid: localBloc.customer?.value ==
                                                    null ||
                                                localBloc.customer?.value == ""
                                            ? false
                                            : true,
                                        value: localBloc.customer?.name ?? "",
                                        title: "Customer",
                                        titleModal: "Customer List",
                                        onSelected: (cust) {
                                          localBloc.add(
                                            CallsheetSetForm(
                                              customer: KeyValue(
                                                  name: cust['name'],
                                                  value: cust['_id']),
                                            ),
                                          );
                                          localBloc.add(
                                            CallsheetResetForm(
                                              contact: true,
                                            ),
                                          );
                                          picC.text = "";
                                          phoneC.text = "";
                                          Get.back();
                                        },
                                        onReset: () {
                                          localBloc.add(
                                            CallsheetResetForm(
                                                customer: true, contact: true),
                                          );
                                          picC.text = "";
                                          phoneC.text = "";
                                        },
                                        mandatory: true,
                                        disabled: state.data.status != "0",
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: localBloc.customer?.value != null &&
                                      localBloc.customer?.value != "",
                                  child: Column(
                                    children: [
                                      FieldDataScroll(
                                        ComponentInsert: ContactFormScreen(
                                          onSave: (dynamic e) {
                                            localBloc.add(
                                              CallsheetSetForm(
                                                contact: KeyValue(
                                                  name: e['name'],
                                                  value: e['_id'],
                                                ),
                                              ),
                                            );

                                            positionC.text = e['position'];
                                            phoneC.text = e['phone'].toString();
                                          },
                                          contactBloc: ContactBloc(),
                                          customer: localBloc.customer,
                                        ),
                                        endpoint: Endpoint(
                                          data: Data.contact,
                                          filters: [
                                            [
                                              "customer",
                                              "=",
                                              localBloc.customer?.value !=
                                                          null &&
                                                      localBloc.customer
                                                              ?.value !=
                                                          ""
                                                  ? localBloc.customer!.value
                                                  : "",
                                            ]
                                          ],
                                        ),
                                        valid: localBloc.contact?.value ==
                                                    null ||
                                                localBloc.contact?.value == ""
                                            ? false
                                            : true,
                                        value: localBloc.contact?.name ?? "",
                                        title: "Contact",
                                        titleModal: "Contact List",
                                        onSelected: (e) {
                                          localBloc.add(
                                            CallsheetSetForm(
                                              contact: KeyValue(
                                                  name: e['name'],
                                                  value: e['_id']),
                                            ),
                                          );
                                          positionC.text = e['position'];
                                          phoneC.text = e['phone'].toString();
                                          Get.back();
                                        },
                                        onReset: () {
                                          localBloc.add(
                                            CallsheetResetForm(
                                              contact: true,
                                            ),
                                          );
                                          picC.text = "";
                                          phoneC.text = "";
                                        },
                                        mandatory: true,
                                        disabled: state.data.status != "0",
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: localBloc.contact?.value != null &&
                                      localBloc.contact?.value != "",
                                  child: Column(
                                    children: [
                                      CustomField(
                                        mandatory: true,
                                        title: "Position",
                                        controller: positionC,
                                        type: Type.standard,
                                        disabled: true,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      CustomField(
                                        mandatory: true,
                                        title: "Phone",
                                        controller: phoneC,
                                        type: Type.standard,
                                        disabled: true,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        CustomField(
                          title: "Status",
                          controller: workflowC,
                          type: Type.standard,
                          disabled: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                SlidingUpPanel(
                  controller: panelController,
                  defaultPanelState: PanelState.CLOSED,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  parallaxEnabled: true,
                  maxHeight: Get.height / 1.25,
                  minHeight: 30,
                  panel: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              panelController.isPanelOpen
                                  ? panelController.close()
                                  : panelController.open();
                            },
                            child: Container(
                              width: 30,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ListView.builder(
                              itemCount: state.history.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 52, 52, 52),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 32, 32, 32), // Warna border
                                        width: 1.0, // Ketebalan border
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.history[index].user.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            Text(
                                              DateFormat.yMd().add_jm().format(
                                                    DateTime.parse(
                                                            "${state.history[index].createdAt}")
                                                        .toLocal(),
                                                  ),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          state.history[index].message,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
