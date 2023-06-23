// ignore_for_file: must_be_immutable, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/screens/home/home_screen.dart';

class BottomNavigator extends StatelessWidget {
  int active = 0;

  BottomNavigator(this.active, {super.key});

  @override
  Widget build(BuildContext context) {
    void actionTab(int index) {}
    return BottomNavigationBar(
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).push(
              MaterialPageRoute<HomeScreen>(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<AuthBloc>(context),
                  child: const HomeScreen(),
                ),
              ),
            );
            break;
          case 1:
            // Get.offAllNamed(Routes.SO);
            break;
          case 2:
            // Get.toNamed(Routes.USERSETTING);
            break;
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_open_outlined),
          label: 'Sales Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: active,
      selectedItemColor: const Color(0xFF303747),
    );
  }
}
