// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, must_be_immutable, deprecated_member_use, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/repositories/branch_repository.dart';
import 'package:salesappnew/repositories/customer_group_repository.dart';
import 'package:salesappnew/repositories/user_repository.dart';
import 'package:salesappnew/screens/visit/widgets/visit_body.dart';
import 'package:salesappnew/screens/visit/widgets/visit_modal_insert.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:salesappnew/widgets/field_custom.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';
// import 'package:salesappnew/widgets/drawer_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VisitScreen extends StatelessWidget {
  VisitScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    TabBar MyTabBar = TabBar(
      indicatorColor: const Color(0xFFF9D934),
      // controller: VisitC.controllerTab,
      tabs: myTabs,
    );

    final PanelController _panelController = PanelController();
    VisitBloc bloc = VisitBloc();
    TextEditingController typeC = TextEditingController();
    TextEditingController branchC = TextEditingController();
    TextEditingController groupC = TextEditingController();
    TextEditingController createdByC = TextEditingController();
    TextEditingController rangeDateC = TextEditingController();

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
                          child: ListView(
                            children: [
                              const SizedBox(height: 20),
                              FieldCustom(
                                onReset: () {
                                  bloc.add(
                                    GetData(
                                      getRefresh: true,
                                      search: bloc.search,
                                      status: bloc.tabActive!,
                                    ),
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
                                    GetData(
                                      filters: [
                                        ["type", "=", e['value']]
                                      ],
                                      getRefresh: true,
                                      search: bloc.search,
                                      status: bloc.tabActive!,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              FieldDataScroll(
                                minWidth: Get.width - 100,
                                endpoint: Endpoint(data: Data.branch),
                                value: bloc.branch?.name ?? "",
                                title: "Branch",
                                titleModal: "Branch List",
                                onSelected: (e) {},
                                onReset: () {},
                              ),
                              const SizedBox(height: 20),
                              FieldCustom(
                                type: Type.select,
                                controller: createdByC,
                                suggestionTitle: "name",
                                title: "CreatedBy",
                                getData: (String search) async {
                                  return await UserRepositoryGetAll(
                                    search: search,
                                  );
                                },
                                onSelect: (e) {
                                  createdByC.text = e['name'];
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    border: const OutlineInputBorder(),
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "WorkflowState :",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                enabled: true,
                                autocorrect: false,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                  hintText: "Select State",
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ],
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
