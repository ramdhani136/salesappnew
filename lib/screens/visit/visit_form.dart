// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/action_model.dart';
import 'package:salesappnew/screens/visit/widgets/visit_form_info.dart';
import 'package:salesappnew/widgets/bottom_navigator.dart';
import 'package:salesappnew/widgets/drawe_app_button.dart';

class VisitForm extends StatelessWidget {
  String id;
  VisitForm({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    List<Tab> myTabs = <Tab>[
      const Tab(
        child: Row(
          children: [
            Icon(
              Icons.info,
              color: Color.fromARGB(255, 72, 72, 72),
              size: 16,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Info",
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 75, 75, 75),
              ),
            ),
          ],
        ),
      ),
      const Tab(
        child: Row(
          children: [
            Icon(
              Icons.task,
              color: Color.fromARGB(255, 72, 72, 72),
              size: 16,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Task",
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 75, 75, 75),
              ),
            ),
          ],
        ),
      ),
      const Tab(
        child: Row(
          children: [
            Icon(
              Icons.note,
              color: Color.fromARGB(255, 72, 72, 72),
              size: 16,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Result",
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 75, 75, 75),
              ),
            ),
          ],
        ),
      ),
    ];

    TabBar MyTabBar = TabBar(
      indicatorColor: const Color(0xFFF9D934),
      // controller: VisitC.controllerTab,
      tabs: myTabs,
    );

    return BlocProvider(
      create: (context) => VisitBloc()..add(ShowData(id)),
      child: DefaultTabController(
        initialIndex: 0,
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFE6212A),
            title: BlocBuilder<VisitBloc, VisitState>(
              builder: (context, state) {
                if (state is IsLoading) {
                  return Text("Loading...");
                }

                if (state is IsShowLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const DrawerAppButton(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.article_outlined, size: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Text(
                              " Visit (${state.data.status == "1" ? "Compeleted" : state.data.status == "0" ? "Draft" : "Canceled"})",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        Visibility(
                            visible: state.workflow.isNotEmpty,
                            child: PopupMenuButton(
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(
                                Icons.more_vert,
                                color: Color.fromARGB(255, 121, 8, 14),
                              ),
                              itemBuilder: (context) {
                                return state.workflow.map((item) {
                                  return PopupMenuItem(
                                    child: InkWell(
                                      onTap: () async {
                                        Get.back();
                                        print(item.nextState.id);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Text(item.action),
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                            )),
                      ])
                    ],
                  );
                }
                return Container();
              },
            ),
            centerTitle: true,
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
          body: Padding(
            padding: EdgeInsets.only(bottom: 200),
            child: TabBarView(
              children: [
                VisitFormInfo(),
                Text("home"),
                Text("home"),
              ],
            ),
          ),
          bottomNavigationBar: BlocProvider.value(
            value: BlocProvider.of<AuthBloc>(context),
            child: BottomNavigator(2),
          ),
        ),
      ),
    );
  }
}
