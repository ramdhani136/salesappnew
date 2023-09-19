// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, must_be_immutable, deprecated_member_use, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/_stub/_file_decoder_stub.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_body.dart';
import 'package:salesappnew/screens/visit/widgets/visit_modal_insert.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/utils/local_data.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:salesappnew/widgets/field_custom.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';
// import 'package:salesappnew/widgets/drawer_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';

class VisitScreen extends StatefulWidget {
  const VisitScreen({super.key});

  @override
  State<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen> {
  List<Tab> myTabs = <Tab>[
    const Tab(
      child: Text(
        "ACTIVE",
        style: TextStyle(
          fontSize: 13,
          color: Color.fromARGB(255, 75, 75, 75),
        ),
      ),
    ),
    const Tab(
      child: Text(
        "COMPLETED",
        style: TextStyle(
          fontSize: 13,
          color: Color.fromARGB(255, 75, 75, 75),
        ),
      ),
    ),
    const Tab(
      child: Text(
        "CANCELED",
        style: TextStyle(
          fontSize: 13,
          color: Color.fromARGB(255, 75, 75, 75),
        ),
      ),
    ),
  ];

  final PanelController _panelController = PanelController();

  VisitBloc bloc = VisitBloc();
  TextEditingController typeC = TextEditingController();
  TextEditingController rangeDateC = TextEditingController();

  @override
  void initState() {
    GetLocalFIlter();

    super.initState();
  }

  Future<void> GetLocalFIlter() async {
    dynamic value = await LocalData().getData("filterVisit");
    List data = json.decode(value);
    print(data);

    List<FilterModel> isFil = data.map((dynamic item) {
      return FilterModel(
        field: item["field"],
        name: item["name"],
        value: item["value"],
      );
    }).toList();
    bloc.filterLocal = isFil;
  }

  @override
  void dispose() {
    _panelController.close();
    // bloc.close();
    typeC.clear();
    rangeDateC.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabBar MyTabBar = TabBar(
      indicatorColor: const Color(0xFFF9D934),
      // controller: VisitC.controllerTab,
      tabs: myTabs,
    );

    ChooseDateRangePicker() async {
      DateTimeRange? picked = await showDateRangePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              splashColor: Colors.black,
              textTheme: const TextTheme(
                subtitle1: TextStyle(color: Colors.black),
                button: TextStyle(color: Colors.black),
              ),
              hintColor: Colors.black,
              colorScheme: const ColorScheme.light(
                  primary: Color(0xFFE6212A),
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? const Text(""),
          );
        },
        firstDate: DateTime(DateTime.now().year - 20),
        lastDate: DateTime.now(),
        initialDateRange: DateTimeRange(
          start: DateTime(DateTime.now().year, DateTime.now().month - 6,
              DateTime.now().day),
          end: DateTime.now(),
        ),
      );

      if (picked != null) {
        rangeDateC.text =
            "${DateFormat("dd MMM yyyy").format(picked.start)} - ${DateFormat("dd MMM yyyy").format(picked.end).toString()} ";
      }
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bloc,
        ),
      ],
      child: DefaultTabController(
        initialIndex: 1,
        length: myTabs.length,
        child: Scaffold(
          // drawer: const DrawerWidget(),
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFE6212A),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButtonCustom(),
                const Row(
                  children: [
                    Icon(Icons.directions_run, size: 17),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        "Visit List",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  // IconSearch(),
                  IconButton(
                    onPressed: () {
                      bloc.group = null;
                      bloc.customer = null;
                      showDialog(
                        context: context,
                        builder: (context) => VisitModalInsert(
                          bloc: bloc,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 121, 8, 14),
                    ),
                  ),
                ])
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(MyTabBar.preferredSize.height),
              child: Container(
                height: 55,
                color: Colors.white,
                child: TabBar(
                  indicatorColor: const Color(0xFFF9D934),
                  tabs: myTabs,
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              const TabBarView(
                children: [
                  VisitBody(
                    status: 0,
                    colorFontHeader: Color.fromARGB(255, 250, 236, 214),
                    colorHeader: Color(0xFFE8A53A),
                  ),
                  VisitBody(
                    colorFontHeader: Color.fromARGB(255, 190, 255, 240),
                    colorHeader: Color(0xFF20826B),
                    status: 1,
                  ),
                  VisitBody(
                    colorFontHeader: Color.fromARGB(255, 230, 230, 230),
                    colorHeader: Color(0xFF657187),
                    status: 2,
                  ),
                ],
              ),
              SlidingUpPanel(
                controller: _panelController,
                defaultPanelState: PanelState.CLOSED,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                parallaxEnabled: true,
                maxHeight: Get.height / 1.3,
                minHeight: 30,
                panel: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _panelController.isPanelOpen
                                ? _panelController.close()
                                : _panelController.open();
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
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 25,
                            right: 25,
                          ),
                          child: BlocBuilder<VisitBloc, VisitState>(
                            bloc: bloc,
                            builder: (context, state) {
                              String GetValue(String field) {
                                if (bloc.filterLocal != null) {
                                  List<FilterModel> result = bloc.filterLocal!
                                      .where((FilterModel element) =>
                                          element.field == field)
                                      .toList();
                                  if (result.isNotEmpty) {
                                    return result[0].name;
                                  }
                                  return "";
                                }

                                return "";
                              }

                              return ListView(
                                children: [
                                  const SizedBox(height: 20),
                                  FieldCustom(
                                    placeholder: "",
                                    onReset: () {
                                      bloc.add(
                                        RemoveFilterData(value: "type"),
                                      );
                                    },
                                    controller: typeC,
                                    type: Type.select,
                                    getData: (String search) {
                                      return const [
                                        {"name": "Insite", "value": "insite"},
                                        {"name": "Outsite", "value": "outsite"}
                                      ];
                                    },
                                    title: "Type",
                                    onSelect: (e) {
                                      typeC.text = e['name'];

                                      bloc.add(
                                        SetFilterData(
                                          filter: ["type", "=", e['value']],
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  FieldDataScroll(
                                    minWidth: Get.width - 100,
                                    endpoint: Endpoint(data: Data.branch),
                                    value: GetValue("customer.branch"),
                                    title: "Branch",
                                    titleModal: "Branch List",
                                    onSelected: (e) {
                                      Get.back();

                                      bloc.add(
                                        SetFilter(
                                          filter: FilterModel(
                                            field: "customer.branch",
                                            name: e["name"],
                                            value: e["_id"],
                                          ),
                                        ),
                                      );
                                    },
                                    onReset: () {
                                      bloc.add(
                                        RemoveFilterData(
                                            value: "customer.branch"),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  FieldDataScroll(
                                    minWidth: Get.width - 100,
                                    endpoint:
                                        Endpoint(data: Data.customergroup),
                                    value: GetValue("customer.customerGroup"),
                                    title: "Group",
                                    titleModal: "Group List",
                                    onSelected: (e) {
                                      Get.back();
                                      bloc.add(
                                        SetFilter(
                                          filter: FilterModel(
                                            field: "customer.customerGroup",
                                            name: e["name"],
                                            value: e["_id"],
                                          ),
                                        ),
                                      );
                                    },
                                    onReset: () {
                                      bloc.add(
                                        RemoveFilterData(
                                            value: "customer.customerGroup"),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  FieldDataScroll(
                                    minWidth: Get.width - 100,
                                    endpoint: Endpoint(data: Data.customer),
                                    value: GetValue("customer"),
                                    title: "Customer",
                                    titleModal: "Customer List",
                                    onSelected: (e) {
                                      Get.back();
                                      bloc.add(
                                        SetFilterData(
                                          filter: ["customer", "=", e['_id']],
                                        ),
                                      );
                                    },
                                    onReset: () {
                                      bloc.add(
                                        RemoveFilterData(value: "customer"),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  FieldDataScroll(
                                    minWidth: Get.width - 100,
                                    endpoint: Endpoint(data: Data.users),
                                    value: GetValue("createdBy"),
                                    title: "Created By",
                                    titleModal: "User List",
                                    onSelected: (e) {
                                      Get.back();
                                      bloc.add(
                                        SetFilterData(
                                          filter: ["createdBy", "=", e['_id']],
                                        ),
                                      );
                                    },
                                    onReset: () {
                                      bloc.add(
                                        RemoveFilterData(value: "createdBy"),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Date :",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      ChooseDateRangePicker();
                                    },
                                    child: TextField(
                                      style: TextStyle(color: Colors.grey[900]),
                                      controller: rangeDateC,
                                      enabled: false,
                                      autocorrect: false,
                                      enableSuggestions: false,
                                      decoration: InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.grey[300]),
                                        hintText: "Select date",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        border: const OutlineInputBorder(),
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  FieldDataScroll(
                                    minWidth: Get.width - 100,
                                    endpoint:
                                        Endpoint(data: Data.workflowState),
                                    value: bloc.branch?.name ?? "",
                                    title: "Workflow State",
                                    titleModal: "Workflow State List",
                                    onSelected: (e) {},
                                    onReset: () {},
                                  ),
                                ],
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
        ),
      ),
    );
  }
}
