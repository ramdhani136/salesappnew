// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/callsheet/callsheet_bloc.dart';
import 'package:salesappnew/screens/callsheet/widgets/callsheet_form_bill.dart';
import 'package:salesappnew/screens/callsheet/widgets/callsheet_form_info.dart';
import 'package:salesappnew/screens/callsheet/widgets/callsheet_form_result.dart';
import 'package:salesappnew/screens/callsheet/widgets/callsheet_form_task.dart';

import 'package:salesappnew/widgets/back_button_custom.dart';

class CallsheetForm extends StatelessWidget {
  String id;
  CallsheetBloc bloc;
  CallsheetForm({super.key, required this.id, required this.bloc}) {
    bloc.add(CallsheetShowData(id: id));
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
        if (bloc.tabActive != null) {
          bloc.add(CallsheetGetAllData(
            status: bloc.tabActive!,
            getRefresh: true,
            search: bloc.search,
          ));
        }
        return true;
      },
      child: BlocProvider.value(
        value: bloc,
        child: DefaultTabController(
          initialIndex: 0,
          length: myTabs.length,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFFE6212A),
              title: BlocListener<CallsheetBloc, CallsheetState>(
                listener: (context, state) {
                  if (state is CallsheetIsFailure) {
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
                                // Tindakan yang ingin Anda lakukan saat tombol OK ditekan
                                Navigator.of(context).pop(); // Menutup dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: BlocBuilder<CallsheetBloc, CallsheetState>(
                  builder: (context, state) {
                    if (state is CallsheetIsLoading) {
                      return const Text(
                        "Loading...",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      );
                    }

                    if (state is CallsheetIsShowLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButtonCustom(onBack: () {
                            bloc.add(CallsheetGetAllData(
                              status: bloc.tabActive ?? 1,
                              getRefresh: true,
                              search: bloc.search,
                            ));
                          }),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.article_outlined, size: 16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  " Callsheet (${state.data.status == "1" ? "Compeleted" : state.data.status == "0" ? "Draft" : "Canceled"})",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: Color.fromARGB(255, 121, 8, 14),
                                ),
                              ),
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
                                            BlocProvider.of<CallsheetBloc>(
                                                    context)
                                                .add(
                                              CallsheetChangeWorkflow(
                                                  id: id,
                                                  nextStateId:
                                                      item.nextState.id),
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
                const CallsheetFormInfo(),
                CallsheetFormTask(id: id),
                CallsheetFormBill(id: id),
                CallsheetFormResult(callsheetId: id),
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
