import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/screens/home/home_screen.dart';
import 'package:salesappnew/screens/login_screen.dart';
import 'dart:io';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            AuthRepository(),
          )..add(AppStarted()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            print(state);
            if (state is AuthUnauthenticated) {
              Navigator.of(context).push(
                MaterialPageRoute<LoginScreen>(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<AuthBloc>(context),
                    child: const LoginScreen(),
                  ),
                ),
              );
            }
            if (state is AuthAuthenticated) {
              Navigator.of(context).push(
                MaterialPageRoute<LoginScreen>(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<AuthBloc>(context),
                    child: const HomeScreen(),
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              // Tampilkan halaman kosong jika tidak ada kondisi yang cocok
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
