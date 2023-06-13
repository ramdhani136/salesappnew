import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/screens/home/home_screen.dart';
import 'package:salesappnew/screens/login_screen.dart';
import 'dart:io';

import 'package:salesappnew/utils/location_gps.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthBloc(AuthRepository()),
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthInitial) {
            context.read<AuthBloc>().add(AppStarted());
          }

          if (state is AuthAuthenticated) {
            return HomeScreen();
          }
          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return LoginScreen();
        }),
      ),
    );
  }
}
