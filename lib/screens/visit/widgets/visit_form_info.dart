// ignore_for_file: invalid_use_of_visible_for_testing_member, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/bloc/contact/contact_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/screens/callsheet/widgets/customer_form_widget.dart';
import 'package:salesappnew/screens/contact/contact_form_screen.dart';
import 'package:salesappnew/screens/visit/checkin_screen.dart';
import 'package:salesappnew/screens/visit/widgets/checkout_screen.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VisitFormInfo extends StatefulWidget {
  const VisitFormInfo({
    super.key,
  });

  @override
  State<VisitFormInfo> createState() => _VisitFormInfoState();
}

class _VisitFormInfoState extends State<VisitFormInfo> {
  TextEditingController typeC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController checkInC = TextEditingController();
  TextEditingController checkOutC = TextEditingController();
  TextEditingController workflowC = TextEditingController();
  TextEditingController picC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController positionC = TextEditingController();
  VisitBloc bloc = VisitBloc();
  @override
  void dispose() {
    super.dispose();
    checkInC.dispose();
    checkOutC.dispose();
    typeC.dispose();
    nameC.dispose();
    workflowC.dispose();
    picC.dispose();
    phoneC.dispose();
    positionC.dispose();
    dateC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PanelController panelController = PanelController();

    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        VisitBloc visitBloc = BlocProvider.of<VisitBloc>(context);

        if (state is IsFailure) {
          Center(
            child: Text(state.error),
          );
        }

        if (state is IsShowLoaded) {
          typeC.text = state.data.type == "insite" ? "In site" : "Out Site";
          nameC.text = state.data.name!;
          if (state.data.checkIn != null) {
            checkInC.text = state.data.checkIn != null
                ? "${state.data.checkIn?.address} - ${DateFormat.yMd().add_jm().format(
                      DateTime.parse("${state.data.checkIn!.createdAt}")
                          .toLocal(),
                    )}"
                : "";
          }
          if (state.data.checkOut != null) {
            checkOutC.text = state.data.checkOut != null
                ? "${state.data.checkOut?.address} - ${DateFormat.yMd().add_jm().format(
                      DateTime.parse("${state.data.checkOut!.createdAt}")
                          .toLocal(),
                    )}"
                : "";
          }

          workflowC.text = state.data.workflowState!;
          bloc.branch = visitBloc.branch;
          bloc.group = visitBloc.group;
          bloc.customer = visitBloc.customer;
          bloc.pickedFile = null;
          bloc.checkInLat = null;
          bloc.checkInLng = null;
          bloc.type = null;
          if (state.data.contact != null) {
            bloc.contact = KeyValue(
              name: state.data.contact!.name,
              value: state.data.contact?.id,
            );
          } else {
            bloc.contact = null;
          }
          bloc.type = state.data.type;
          picC.text =
              state.data.contact != null ? state.data.contact!.name : "";
          positionC.text =
              state.data.contact != null ? state.data.contact!.position : "";
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
                      top: 10,
                      bottom: 30,
                    ),
                    child: ListView(
                      children: [
                        BlocBuilder<VisitBloc, VisitState>(
                          bloc: bloc,
                          builder: (context, stateNew) {
                            return Visibility(
                              visible: state.data.type == "outsite" ||
                                  bloc.type == "outsite",
                              child: Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      width: Get.width * 0.9,
                                      height: Get.width / 1.65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 232, 231, 231),
                                        ),
                                      ),
                                      child: state.data.img == null &&
                                              bloc.pickedFile == null &&
                                              state.data.img == ""
                                          ? const Center(
                                              child: Icon(
                                              Icons.hide_image_outlined,
                                              color: Color(0xFFE0E0E0),
                                              size: 100,
                                            ))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: bloc.pickedFile != null
                                                  ? FadeInImage(
                                                      fit: BoxFit.fitHeight,
                                                      fadeInCurve:
                                                          Curves.easeInExpo,
                                                      fadeOutCurve:
                                                          Curves.easeOutExpo,
                                                      placeholder: const AssetImage(
                                                          'assets/images/loading.gif'),
                                                      image: FileImage(File(bloc
                                                          .pickedFile!.path)),
                                                    )
                                                  : state.data.img != null &&
                                                          state.data.img != ""
                                                      ? FadeInImage(
                                                          fit: BoxFit.fitHeight,
                                                          fadeInCurve:
                                                              Curves.easeInExpo,
                                                          fadeOutCurve: Curves
                                                              .easeOutExpo,
                                                          placeholder:
                                                              const AssetImage(
                                                                  'assets/images/loading.gif'),
                                                          image: NetworkImage(
                                                            "${Config().baseUri}public/${state.data.img}",
                                                          ),
                                                          imageErrorBuilder:
                                                              (_, __, ___) {
                                                            return Image.asset(
                                                              'assets/images/noimage.jpg',
                                                            );
                                                          },
                                                        )
                                                      : const Center(
                                                          child: Icon(
                                                            Icons
                                                                .hide_image_outlined,
                                                            color: Color(
                                                                0xFFE0E0E0),
                                                            size: 100,
                                                          ),
                                                        ),
                                            ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      width: Get.width * 0.9,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          if (state.data.status == "0") {
                                            bloc.add(
                                              VisitChangeImage(),
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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
                        BlocBuilder<VisitBloc, VisitState>(
                          bloc: bloc,
                          builder: (context, stateVisit) {
                            return Column(
                              children: [
                                FieldDataScroll(
                                  mandatory: true,
                                  endpoint: Endpoint(data: Data.branch),
                                  valid: bloc.branch?.value == null ||
                                          bloc.branch?.value == ""
                                      ? false
                                      : true,
                                  value: bloc.branch?.name ?? "",
                                  title: "Branch",
                                  titleModal: "Branch List",
                                  onSelected: (e) {
                                    bloc.add(
                                      VisitSetForm(
                                        branch: KeyValue(
                                            name: e['name'], value: e['_id']),
                                      ),
                                    );
                                    bloc.add(
                                      VisitResetForm(
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
                                    bloc.add(
                                      VisitResetForm(
                                        branch: true,
                                        customer: true,
                                        group: true,
                                        contact: true,
                                      ),
                                    );
                                    picC.text = "";
                                    phoneC.text = "";
                                  },
                                  disabled: state.data.status != "0" ||
                                      state.data.checkOut != null,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Visibility(
                                  visible: bloc.branch?.value != null &&
                                      bloc.branch?.value != "",
                                  child: Column(
                                    children: [
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
                                          bloc.add(
                                            VisitSetForm(
                                              group: KeyValue(
                                                  name: e['name'],
                                                  value: e['_id']),
                                            ),
                                          );

                                          bloc.add(
                                            VisitResetForm(
                                              customer: true,
                                              contact: true,
                                            ),
                                          );
                                          picC.text = "";
                                          phoneC.text = "";
                                          Get.back();
                                        },
                                        onReset: () {
                                          bloc.add(
                                            VisitResetForm(
                                                customer: true,
                                                group: true,
                                                contact: true),
                                          );
                                          picC.text = "";
                                          phoneC.text = "";
                                        },
                                        mandatory: true,
                                        disabled: state.data.status != "0" ||
                                            state.data.checkOut != null,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: bloc.group?.value != null &&
                                      bloc.group?.value != "",
                                  child: Column(
                                    children: [
                                      FieldDataScroll(
                                        ComponentInsert: CustomerFormWidget(
                                          branch: bloc.branch,
                                          group: bloc.group,
                                          onSuccess: (e) {
                                            bloc.add(
                                              VisitSetForm(
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
                                        onSelected: (cust) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return CheckInScreen(
                                                  customerId: cust["_id"],
                                                  bloc: bloc,
                                                  onCheckIn: (e) {
                                                    bloc.checkInLat =
                                                        e['checkInLat'];
                                                    bloc.checkInLng =
                                                        e['checkInLng'];
                                                    bloc.type = e['type'];

                                                    typeC.text =
                                                        e["type"] == "insite"
                                                            ? "In Site"
                                                            : "Out Site";
                                                    bloc.add(
                                                      VisitSetForm(
                                                        customer: KeyValue(
                                                            name: cust['name'],
                                                            value: cust['_id']),
                                                      ),
                                                    );
                                                    bloc.add(
                                                      VisitResetForm(
                                                        contact: true,
                                                      ),
                                                    );
                                                    picC.text = "";
                                                    phoneC.text = "";
                                                    Get.back();
                                                    Get.back();
                                                    Get.back();
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        onReset: () {
                                          bloc.add(
                                            VisitResetForm(
                                                customer: true, contact: true),
                                          );
                                          picC.text = "";
                                          phoneC.text = "";
                                        },
                                        mandatory: true,
                                        disabled: state.data.status != "0" ||
                                            state.data.checkOut != null,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: bloc.customer?.value != null &&
                                      bloc.customer?.value != "",
                                  child: Column(
                                    children: [
                                      FieldDataScroll(
                                        ComponentInsert: ContactFormScreen(
                                          onSave: (dynamic e) {
                                            bloc.add(
                                              VisitSetForm(
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
                                          customer: bloc.customer,
                                        ),
                                        endpoint: Endpoint(
                                          data: Data.contact,
                                          filters: [
                                            [
                                              "customer",
                                              "=",
                                              bloc.customer?.value != null &&
                                                      bloc.customer?.value != ""
                                                  ? bloc.customer!.value
                                                  : "",
                                            ]
                                          ],
                                        ),
                                        valid: bloc.contact?.value == null ||
                                                bloc.contact?.value == ""
                                            ? false
                                            : true,
                                        value: bloc.contact?.name ?? "",
                                        title: "Contact",
                                        titleModal: "Contact List",
                                        onSelected: (e) {
                                          bloc.add(
                                            VisitSetForm(
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
                                          bloc.add(
                                            VisitResetForm(
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
                                  visible: bloc.contact?.value != null &&
                                      bloc.contact?.value != "",
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
                        Visibility(
                          visible: checkInC.text != "",
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Check In",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                ],
                              ),
                              TextField(
                                readOnly: true,
                                maxLines: null,
                                controller: checkInC,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: checkOutC.text != "",
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Check Out",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                ],
                              ),
                              TextField(
                                readOnly: true,
                                maxLines: null,
                                controller: checkOutC,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
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
                                height: Get.width / 1.7,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 214, 214, 214),
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
            floatingActionButton: BlocBuilder<VisitBloc, VisitState>(
              builder: (context, state) {
                return BlocBuilder<VisitBloc, VisitState>(
                  bloc: bloc,
                  builder: (context, stateNew) {
                    bool isChange = false;
                    if ((visitBloc.branch?.value != bloc.branch?.value) ||
                        (visitBloc.group?.value != bloc.group?.value) ||
                        (visitBloc.customer?.value != bloc.customer?.value) ||
                        (visitBloc.pickedFile?.path != bloc.pickedFile?.path) ||
                        (visitBloc.contact?.value != bloc.contact?.value)) {
                      isChange = true;
                    } else {
                      isChange = false;
                    }

                    if (state is IsShowLoaded) {
                      if (state.data.status == "0") {
                        if (state.data.checkOut == null && !isChange) {
                          return SizedBox(
                            height: 60.0,
                            width: 60.0,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<CheckOutScreen>(
                                    builder: (_) => BlocProvider.value(
                                      value:
                                          BlocProvider.of<VisitBloc>(context),
                                      child: const CheckOutScreen(),
                                    ),
                                  ),
                                );
                              },
                              backgroundColor: Colors.grey[850],
                              child: const Icon(
                                Icons.done_outlined,
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else if (isChange) {
                          return SizedBox(
                            height: 60.0,
                            width: 60.0,
                            child: FloatingActionButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Are you sure to save?",
                                  content: Container(),
                                  textConfirm: "Confirm",
                                  textCancel: "Cancel",
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    Get.back();
                                    if (bloc.branch?.value == null ||
                                        bloc.branch?.value == "") {
                                      Fluttertoast.showToast(
                                        msg: "Branch wajib diisi!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.grey[800],
                                        textColor: Colors.white,
                                      );
                                      return;
                                    }
                                    if (bloc.group?.value == null ||
                                        bloc.group?.value == "") {
                                      Fluttertoast.showToast(
                                        msg: "Group wajib diisi!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.grey[800],
                                        textColor: Colors.white,
                                      );
                                      return;
                                    }
                                    if (bloc.customer?.value == null ||
                                        bloc.customer?.value == "") {
                                      Fluttertoast.showToast(
                                        msg: "Customer wajib diisi!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.grey[800],
                                        textColor: Colors.white,
                                      );
                                      return;
                                    }
                                    if (bloc.contact?.value == null ||
                                        bloc.contact?.value == "") {
                                      Fluttertoast.showToast(
                                        msg: "Contact wajib diisi!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.grey[800],
                                        textColor: Colors.white,
                                      );
                                      return;
                                    }

                                    Map<String, dynamic> upData = {};

                                    if (state.data.checkOut == null) {
                                      upData = {
                                        "customer": bloc.customer?.value,
                                        "customerGroup": bloc.group?.value,
                                        "branch": bloc.branch?.value,
                                        "contact": bloc.contact?.value,
                                      };
                                    } else {
                                      upData = {
                                        "contact": bloc.contact?.value,
                                      };
                                    }

                                    if (bloc.checkInLat != null &&
                                        bloc.checkInLng != null &&
                                        bloc.type != null) {
                                      upData.addAll(
                                        {
                                          "type": bloc.type,
                                          "checkInLat": bloc.checkInLat,
                                          "checkInLng": bloc.checkInLng,
                                        },
                                      );
                                    }

                                    if (bloc.pickedFile != null) {
                                      visitBloc.pickedFile = bloc.pickedFile;
                                    }

                                    visitBloc.add(
                                      VisitUpdateData(
                                        id: state.data.id!,
                                        data: upData,
                                      ),
                                    );

                                    visitBloc.pickedFile = bloc.pickedFile;
                                  },
                                  buttonColor: Colors.red,
                                  cancelTextColor: Colors.red,
                                );
                              },
                              backgroundColor: Colors.grey[850],
                              child: const Icon(
                                Icons.save_outlined,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                      }
                    }
                    return Container();
                  },
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
