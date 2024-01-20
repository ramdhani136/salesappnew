// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, must_be_immutable, deprecated_member_use, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_body.dart';
import 'package:salesappnew/screens/visit/widgets/visit_modal_insert.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:salesappnew/widgets/field_custom.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    // _panelController.close();
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
        // print(DateFormat("yyy-MM-dd").format(picked.start));
        // print(DateFormat("yyy-MM-dd").format(picked.end));

        List<List<String>>? setDateFilter = [
          ["createdAt", ">=", DateFormat("yyy-MM-dd").format(picked.start)],
          ["createdAt", "<=", DateFormat("yyy-MM-dd").format(picked.end)],
        ];

        if (bloc.filters != null && bloc.filters!.isNotEmpty) {
          List<List<String>>? current = bloc.filters!.where((element) {
            return element[0] != "createdAt";
          }).toList();
          print(current);

          if (current.isNotEmpty) {
            setDateFilter.addAll(current);
          }
        }

        bloc.filters = setDateFilter;

        bloc.add(
          GetData(
            filters: setDateFilter,
            getRefresh: true,
            search: bloc.search,
            status: bloc.tabActive ?? 1,
          ),
        );

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
                BackButtonCustom(toHome: true),
                const Row(
                  children: [
                    Icon(
                      Icons.directions_run,
                      size: 17,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        "Visit List",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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
          body: WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacementNamed(context, '/home');
              return false;
            },
            child: Stack(
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
                                if (bloc.filterLocal != null &&
                                    bloc.filterLocal!.isNotEmpty) {
                                  for (var i = 0;
                                      i < bloc.filterLocal!.length;
                                      i++) {
                                    if (bloc.filterLocal![i].field == "type") {
                                      typeC.text = bloc.filterLocal![i].name;
                                    }
                                  }
                                }

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
                                          RemoveFilter(data: const ["type"]),
                                        );
                                      },
                                      controller: typeC,
                                      type: Type.select,
                                      getData: (String search) {
                                        return const [
                                          {"name": "Insite", "value": "insite"},
                                          {
                                            "name": "Outsite",
                                            "value": "outsite"
                                          }
                                        ];
                                      },
                                      title: "Type",
                                      onSelect: (e) {
                                        typeC.text = e['name'];
                                        bloc.add(
                                          SetFilter(
                                            filter: FilterModel(
                                              field: "type",
                                              name: e["name"],
                                              value: e["value"],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    FieldDataScroll(
                                      resetOpenModal: false,
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
                                          RemoveFilter(
                                            data: const ["customer.branch"],
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    FieldDataScroll(
                                      resetOpenModal: false,
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
                                          RemoveFilter(
                                            data: const [
                                              "customer.customerGroup"
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    FieldDataScroll(
                                      resetOpenModal: false,
                                      minWidth: Get.width - 100,
                                      endpoint: Endpoint(data: Data.customer),
                                      value: GetValue("customer"),
                                      title: "Customer",
                                      titleModal: "Customer List",
                                      onSelected: (e) {
                                        Get.back();
                                        bloc.add(
                                          SetFilter(
                                            filter: FilterModel(
                                              field: "customer",
                                              name: e["name"],
                                              value: e["_id"],
                                            ),
                                          ),
                                        );
                                      },
                                      onReset: () {
                                        bloc.add(
                                          RemoveFilter(
                                            data: const ["customer"],
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    FieldDataScroll(
                                      resetOpenModal: false,
                                      minWidth: Get.width - 100,
                                      endpoint: Endpoint(data: Data.users),
                                      value: GetValue("createdBy"),
                                      title: "Created By",
                                      titleModal: "User List",
                                      onSelected: (e) {
                                        Get.back();
                                        bloc.add(
                                          SetFilter(
                                            filter: FilterModel(
                                              field: "createdBy",
                                              name: e["name"],
                                              value: e["_id"],
                                            ),
                                          ),
                                        );
                                      },
                                      onReset: () {
                                        bloc.add(
                                          RemoveFilter(
                                              data: const ["createdBy"]),
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
                                        style:
                                            TextStyle(color: Colors.grey[900]),
                                        controller: rangeDateC,
                                        enabled: false,
                                        autocorrect: false,
                                        enableSuggestions: false,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Colors.grey[300]),
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
                                    // FieldDataScroll(
                                    //   resetOpenModal: false,
                                    //   minWidth: Get.width - 100,
                                    //   endpoint:
                                    //       Endpoint(data: Data.workflowState),
                                    //   value: GetValue("workflowState"),
                                    //   title: "Workflow State",
                                    //   titleModal: "Workflow State List",
                                    //   onSelected: (e) {
                                    //     Get.back();
                                    //     bloc.add(
                                    //       SetFilter(
                                    //         filter: FilterModel(
                                    //           field: "workflowState",
                                    //           name: e["name"],
                                    //           value: e["name"],
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    //   onReset: () {
                                    //     bloc.add(
                                    //       RemoveFilter(
                                    //         data: const ["workflowState"],
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
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
      ),
    );
  }
}
