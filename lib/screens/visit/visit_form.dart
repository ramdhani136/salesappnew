// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_form_info.dart';
import 'package:salesappnew/widgets/bottom_navigator.dart';
import 'package:salesappnew/widgets/dialog_signature.dart';
import 'package:salesappnew/widgets/drawe_app_button.dart';
import 'package:salesappnew/screens/visit/widgets/visit_checkout.dart';
import 'package:signature/signature.dart';

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
                fontSize: 14,
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
                fontSize: 14,
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
            title: BlocListener<VisitBloc, VisitState>(
              listener: (context, state) {
                if (state is IsFailure) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error Update'),
                        content: Text(state.error),
                        actions: [
                          TextButton(
                            child: Text('OK'),
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
              child: BlocBuilder<VisitBloc, VisitState>(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: Text(
                                " Visit (${state.data.status == "1" ? "Compeleted" : state.data.status == "0" ? "Draft" : "Canceled"})",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
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
                                          BlocProvider.of<VisitBloc>(context)
                                              .add(
                                            ChangeWorkflow(
                                                id: id,
                                                nextStateId: item.nextState.id),
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
                              )),
                        ])
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
              VisitFormInfo(),
              Text("home"),
              Text("home"),
            ],
          ),
          bottomNavigationBar: BlocProvider.value(
            value: BlocProvider.of<AuthBloc>(context),
            child: BottomNavigator(2),
          ),
          floatingActionButton: BlocBuilder<VisitBloc, VisitState>(
            builder: (context, state) {
              if (state is IsShowLoaded) {
                return Visibility(
                  visible: state.data.status == "0",
                  child: SizedBox(
                    height: 150.0,
                    width: 70.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        showCustomModal(
                            context, BlocProvider.of<VisitBloc>(context));
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
        ),
      ),
    );
  }

  void showCustomModal(BuildContext context, VisitBloc visitBloc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Membuat modal menggunakan tinggi penuh
      builder: (BuildContext context) {
        final SignatureController controllerSignature = SignatureController();
        return Center(
          child: Container(
            width: Get.width, // Lebar penuh
            // height: 300, // Tinggi penuh
            height: MediaQuery.of(context).size.height, // Tinggi penuh
            child: BlocBuilder<VisitBloc, VisitState>(
              bloc: visitBloc,
              builder: (context, state) {
                if (state is IsShowLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // InkWell(
                      //   child: Text('Tutup'),
                      //   onTap: () {
                      //     Navigator.of(context).pop(); // Menutup modal
                      //   },
                      // ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: VisitCheckOut(
                                checkInCordinate: LatLng(
                                  state.data.checkIn!.lat!,
                                  state.data.checkIn!.lng!,
                                ),
                                visitBloc: visitBloc,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DialogSignature(
                                    id: id,
                                    visitBloc: visitBloc,
                                  ),
                                );
                              },
                              child: Container(
                                width: Get.width,
                                height: Get.width / 1.5,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                      255,
                                      225,
                                      225,
                                      225,
                                    ),
                                  ),
                                  color: Colors.white,
                                ),
                                child: visitBloc.signature == null
                                    ? Center(
                                        child: Text(
                                          "Please sign",
                                          style: TextStyle(
                                              color: Colors.grey[300]),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child:
                                            Image.memory(visitBloc.signature!),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () {
                            print(visitBloc.checkOutAddress);
                            print(visitBloc.checkOutCordinates);
                            // Aksi saat tombol ditekan
                          },
                          child: Text(
                            'Check Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 33, 143, 36),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      )

                      // Text('Isi modal kustom'),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}
