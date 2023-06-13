import 'package:flutter/material.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final AuthBloc authBloc;

  HomeScreen(this.authBloc);

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
                  authBloc.add(
                    OnLogout(),
                  );
                },
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
