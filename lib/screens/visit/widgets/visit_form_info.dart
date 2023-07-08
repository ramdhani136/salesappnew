import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/bloc/contact/contact_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/checkout_screen.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VisitFormInfo extends StatefulWidget {
  const VisitFormInfo({
    super.key,
  });

  @override
  State<VisitFormInfo> createState() => _VisitFormInfoState();
}

class _VisitFormInfoState extends State<VisitFormInfo> {
  TextEditingController customerC = TextEditingController();
  TextEditingController groupC = TextEditingController();
  TextEditingController branchC = TextEditingController();
  TextEditingController typeC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController workflowC = TextEditingController();
  TextEditingController picC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController dateC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    customerC.dispose();
    groupC.dispose();
    branchC.dispose();
    typeC.dispose();
    nameC.dispose();
    workflowC.dispose();
    picC.dispose();
    phoneC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PanelController panelController = PanelController();

    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        VisitBloc visitBloc = BlocProvider.of<VisitBloc>(context);

        if (state is IsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is IsShowLoaded) {
          customerC.text = state.data.customer!.name;
          groupC.text = state.data.customerGroup!.name;
          branchC.text = state.data.branch!.name;
          typeC.text = state.data.type!;
          nameC.text = state.data.name!;
          workflowC.text = state.data.workflowState!;
          picC.text =
              state.data.contact != null ? state.data.contact!.name : "";
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
                    visitBloc.add(ShowData(id: "${state.data.id}"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
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
                        CustomField(
                          title: "Type",
                          controller: typeC,
                          type: Type.standard,
                          disabled: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomField(
                          title: "Customer",
                          controller: customerC,
                          type: Type.standard,
                          disabled: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomField(
                          title: "Group",
                          controller: groupC,
                          type: Type.standard,
                          disabled: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomField(
                          title: "Branch",
                          controller: branchC,
                          type: Type.standard,
                          disabled: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocProvider(
                          create: (context) => ContactBloc()
                            ..add(GetListInput(
                              customerId: state.data.customer!.id,
                            )),
                          child: BlocBuilder<ContactBloc, ContactState>(
                            builder: (context, stateContact) {
                              return InkWell(
                                child: CustomField(
                                  disabled: state.data.status != "0",
                                  title: "Pic",
                                  controller: picC,
                                  valid: true,
                                  type: Type.select,
                                  // getData: GetContact(),
                                  data: stateContact is ContactInput
                                      ? stateContact.data
                                      : [],
                                  onChange: (e) {
                                    picC.text = e['title'];
                                    phoneC.text = "${e['subTitle']}";
                                    visitBloc.add(
                                      VisitUpdateData(
                                        id: state.data.id!,
                                        data: {"contact": e['value']},
                                      ),
                                    );
                                  },
                                  onReset: () {
                                    picC.text = "";
                                    phoneC.text = "";
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: phoneC.text != "",
                          child: CustomField(
                            title: "Phone",
                            controller: phoneC,
                            type: Type.standard,
                            disabled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                        Visibility(
                          visible: state.data.signature != null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Signature",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: Get.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 214, 214, 214),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: state.data.signature != null
                                      ? Image.memory(
                                          base64.decode(state.data.signature!),
                                        )
                                      : Container(),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
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
                                      color: Color.fromARGB(255, 52, 52, 52),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color.fromARGB(
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
                                          style: TextStyle(
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
            floatingActionButton: BlocBuilder<VisitBloc, VisitState>(
              builder: (context, state) {
                if (state is IsShowLoaded) {
                  return Visibility(
                    visible: state.data.checkOut == null,
                    child: SizedBox(
                      height: 140.0,
                      width: 60.0,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<CheckOutScreen>(
                              builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<VisitBloc>(context),
                                child: const CheckOutScreen(),
                              ),
                            ),
                          );
                        },
                        backgroundColor: Colors.grey[850],
                        child: const Icon(Icons.done_outlined),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          );
        }
        return const Center(
          child: Text("No data"),
        );
      },
    );
  }
}
