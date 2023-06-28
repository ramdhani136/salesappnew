// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_body.dart';
import 'package:salesappnew/widgets/bottom_navigator.dart';
import 'package:salesappnew/widgets/drawe_app_button.dart';
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

  @override
  Widget build(BuildContext context) {
    TabBar MyTabBar = TabBar(
      indicatorColor: const Color(0xFFF9D934),
      // controller: VisitC.controllerTab,
      tabs: myTabs,
    );

    final PanelController _panelController = PanelController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VisitBloc(),
        ),
      ],
      child: DefaultTabController(
        initialIndex: 1,
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFE6212A),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DrawerAppButton(),
                const Row(
                  children: [
                    Icon(Icons.directions_run, size: 17),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        "Visit List",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  // IconSearch(),
                  IconButton(
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute<VisitForm>(
                      //     builder: (_) => MultiBlocProvider(
                      //       providers: [
                      //         BlocProvider.value(
                      //           value: BlocProvider.of<AuthBloc>(context),
                      //         ),
                      //       ],
                      //       child: VisitForm(),
                      //     ),
                      //   ),
                      // );
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
          body: SlidingUpPanel(
            controller: _panelController,
            defaultPanelState: PanelState.CLOSED,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            parallaxEnabled: true,
            maxHeight: Get.height / 2,
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
                          Text(
                            "Type :",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            enabled: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "Select Type",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Group :",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            enabled: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "Select Group",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Branch :",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            enabled: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "Select Branch",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Created By :",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            enabled: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "Select User",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "StarDate :",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            enabled: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "Select Date",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "EndDate :",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            enabled: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "Select Date",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Status :",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            enabled: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "Select status",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
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
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
            body: const Padding(
              padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 90),
              child: TabBarView(
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
            ),
          ),
          // bottomNavigationBar: BlocProvider.value(
          //   value: BlocProvider.of<AuthBloc>(context),
          //   child: BottomNavigator(2),
          // ),
        ),
      ),
    );
  }
}
