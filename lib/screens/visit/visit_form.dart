// ignore_for_file: non_constant_identifier_names, must_be_immutable, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_form_bill.dart';
import 'package:salesappnew/screens/visit/widgets/visit_form_info.dart';
import 'package:salesappnew/screens/visit/widgets/visit_form_task.dart';
import 'package:salesappnew/screens/visit/widgets/visit_form_result.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';

class VisitForm extends StatelessWidget {
  String id;
  VisitBloc visitBloc;
  VisitForm({super.key, required this.id, required this.visitBloc}) {
    visitBloc.add(ShowData(id: id));
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> myTabs = <Tab>[
      const Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                fontSize: 14,
                color: Color.fromARGB(255, 75, 75, 75),
              ),
            ),
          ],
        ),
      ),
      const Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_rounded,
              color: Color.fromARGB(255, 72, 72, 72),
              size: 16,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Task",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 75, 75, 75),
              ),
            ),
          ],
        ),
      ),
      const Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.currency_exchange_sharp,
              color: Color.fromARGB(255, 72, 72, 72),
              size: 16,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Bill",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 75, 75, 75),
              ),
            ),
          ],
        ),
      ),
      const Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Color.fromARGB(255, 72, 72, 72),
              size: 16,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Result",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 75, 75, 75),
              ),
            ),
          ],
        ),
      ),
    ];

    TabBar MyTabBar = TabBar(
      indicatorColor: const Color(0xFFF9D934),
      tabs: myTabs,
    );

    return WillPopScope(
      onWillPop: () async {
        if (visitBloc.tabActive != null) {
          visitBloc.add(GetData(
            status: visitBloc.tabActive!,
            getRefresh: true,
            search: visitBloc.search,
            filters: visitBloc.filters,
          ));
        }
        return true;
      },
      child: BlocProvider.value(
        value: visitBloc,
        child: DefaultTabController(
          initialIndex: 0,
          length: myTabs.length,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFFE6212A),
              title: BlocListener<VisitBloc, VisitState>(
                listener: (context, state) {
                  if (state is IsFailure) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error Update'),
                          content: Text(state.error),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: BlocBuilder<VisitBloc, VisitState>(
                  builder: (context, state) {
                    if (state is IsLoading) {
                      return const Text(
                        "Loading...",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }

                    if (state is IsShowLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButtonCustom(onBack: () {
                            visitBloc.add(GetData(
                              status: visitBloc.tabActive ?? 1,
                              getRefresh: true,
                              filters: visitBloc.filters,
                              search: visitBloc.search,
                            ));
                          }),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.article_outlined,
                                size: 16,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  " Visit (${state.data.status == "1" ? "Compeleted" : state.data.status == "0" ? "Draft" : "Canceled"})",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: const Icon(
                              //     Icons.search,
                              //     color: Color.fromARGB(255, 121, 8, 14),
                              //   ),
                              // ),
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
                                            Get.defaultDialog(
                                              title: "Are you sure?",
                                              content: Container(),
                                              textConfirm: "Confirm",
                                              textCancel: "Cancel",
                                              confirmTextColor: Colors.white,
                                              buttonColor: Colors.red,
                                              cancelTextColor: Colors.red,
                                              onConfirm: () {
                                                BlocProvider.of<VisitBloc>(
                                                        context)
                                                    .add(
                                                  ChangeWorkflow(
                                                      id: id,
                                                      nextStateId:
                                                          item.nextState.id),
                                                );
                                                Get.back();
                                              },
                                            );
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
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                ),
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
            body: TabBarView(
              children: [
                const VisitFormInfo(),
                VisitFormTask(visitId: id),
                VisitFormBill(visitId: id),
                VisitFormResult(visitId: id),
              ],
            ),
            // bottomNavigationBar: BlocProvider.value(
            //   value: BlocProvider.of<AuthBloc>(context),
            //   child: BottomNavigator(2),
            // ),
          ),
        ),
      ),
    );
  }
}
