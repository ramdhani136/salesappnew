import 'package:flutter/material.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/repositories/auth_repository.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  AuthBloc autBloc = AuthBloc(AuthRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home Page"),
            OutlinedButton(
                onPressed: () {
                  autBloc.add(
                    OnLogout(),
                  );
                },
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
