import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/screens/callsheet/callsheet_screen.dart';
import 'package:salesappnew/screens/dn/dn_screen.dart';
import 'package:salesappnew/screens/home/home_screen.dart';
import 'package:salesappnew/screens/invoice/invoice_screen.dart';
import 'package:salesappnew/screens/item/item_screen.dart';
import 'package:salesappnew/screens/login_screen.dart';
import 'package:salesappnew/screens/order/order_screen.dart';
import 'package:salesappnew/screens/visit/visit_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  final authBloc = AuthBloc(AuthRepository());

  runApp(MyApp(
    authBloc: authBloc,
  ));
  configLoading();
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;

  const MyApp({Key? key, required this.authBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => authBloc,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        home: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc..add(AppStarted()),
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            }
            if (state is AuthUnauthenticated) {
              return const LoginScreen();
            }
            if (state is AuthLoading) {
              return Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(color: Colors.grey[400]),
                ),
              );
            }
            return Container();
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/visit': (context) => BlocProvider.value(
                value: authBloc,
                child: const VisitScreen(),
              ),
          '/callsheet': (context) => BlocProvider.value(
                value: authBloc,
                child: const CallsheetScreen(),
              ),
          '/home': (context) => BlocProvider.value(
                value: authBloc,
                child: const HomeScreen(),
              ),
          '/dn': (context) => BlocProvider.value(
                value: authBloc,
                child: const DnScreen(),
              ),
          '/invoice': (context) => BlocProvider.value(
                value: authBloc,
                child: const InvoiceScreen(),
              ),
          '/so': (context) => BlocProvider.value(
                value: authBloc,
                child: const OrderScreen(),
              ),
          '/item': (context) => BlocProvider.value(
                value: authBloc,
                child: const ItemScreen(),
              ),
        },
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}
