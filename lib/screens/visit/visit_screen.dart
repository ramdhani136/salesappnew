import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_body.dart';
import 'package:salesappnew/widgets/bottom_navigator.dart';
import 'package:salesappnew/widgets/drawe_app_button.dart';

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

    return BlocProvider(
      create: (context) => VisitBloc(),
      child: BlocBuilder<VisitBloc, VisitState>(
        builder: (context, state) {
          return DefaultTabController(
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
                    Row(
                      children: const [
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
                        onPressed: () {},
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
                      // controller: VisitC.controllerTab,
                      tabs: myTabs,
                      onTap: (index) {
                        context.read<VisitBloc>().add(TabChanged(index));
                      },
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  VisitBody(state: state),
                  Text('wf'),
                  Text('wg'),
                ],
              ),
              bottomNavigationBar: BottomNavigator(2),
            ),
          );
        },
      ),
    );
  }
}
