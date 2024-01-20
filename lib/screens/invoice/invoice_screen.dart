// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/invoice/invoice_bloc.dart';
import 'package:salesappnew/screens/invoice/widgets/invoice_screen_body.dart';

import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreen();
}

class _InvoiceScreen extends State<InvoiceScreen> {
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
      tabs: myTabs,
    );

    final PanelController _panelController = PanelController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InvoiceBloc(),
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
                BackButtonCustom(
                  toHome: true,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.currency_exchange,
                      size: 17,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        "Invoice",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
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
          body: PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              if (didPop) {
                return;
              }
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Stack(
              children: [
                const TabBarView(
                  children: [
                    InvoiceScreenBody(
                      status: 0,
                      colorFontHeader: Color.fromARGB(255, 250, 236, 214),
                      colorHeader: Color(0xFFE8A53A),
                    ),
                    InvoiceScreenBody(
                      colorFontHeader: Color.fromARGB(255, 190, 255, 240),
                      colorHeader: Color(0xFF20826B),
                      status: 1,
                    ),
                    InvoiceScreenBody(
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
                                    hintText: "Select Type",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
                                    hintText: "Select Group",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
                                    hintText: "Select Branch",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
                                    hintText: "Select User",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
                                    hintText: "Select Date",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
                                    hintText: "Select Date",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
                                    hintText: "Select status",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[300]),
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
      ),
    );
  }
}
