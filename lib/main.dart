import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/screens/home/home_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/screens/login_screen.dart';
// import 'package:salesappnew/bloc/color_bloc2.dart';
// import 'package:salesappnew/screens/latihan/latihan2_screen.dart';
// import 'package:salesappnew/screens/latihan/latihan_screen.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  final authBloc = AuthBloc(AuthRepository());
  authBloc.add(AppStarted());
  runApp(MyApp(authBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;

  MyApp(this.authBloc);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (context, state) {
            if (state is AuthUnauthenticated) {
              return LoginScreen();
            } else if (state is AuthAuthenticated) {
              return HomeScreen(authBloc);
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
