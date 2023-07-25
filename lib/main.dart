import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/screens/callsheet/callsheet_screen.dart';
import 'package:salesappnew/screens/dn/dn_screen.dart';
import 'package:salesappnew/screens/home/home_screen.dart';
import 'package:salesappnew/screens/invoice/invoice_screen.dart';
import 'package:salesappnew/screens/item/item_screen.dart';
import 'package:salesappnew/screens/login_screen.dart';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  AuthBloc authBloc = AuthBloc(AuthRepository())..add(AppStarted());

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authBloc,
      child: GetMaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/visit': (context) => const VisitScreen(),
          '/callsheet': (context) => const CallsheetScreen(),
          '/home': (context) => const HomeScreen(),
          '/dn': (context) => const DnScreen(),
          '/invoice': (context) => const InvoiceScreen(),
          '/so': (context) => const OrderScreen(),
          '/item': (context) => const ItemScreen(),
        },
        debugShowCheckedModeBanner: false,
        // home: BlocListener<AuthBloc, AuthState>(
        //   bloc: authBloc,
        //   listener: (context, state) {
        //     if (state is AuthUnauthenticated) {
        //       Navigator.of(context).push(
        //         MaterialPageRoute<LoginScreen>(
        //           builder: (_) => BlocProvider.value(
        //             value: authBloc,
        //             child: const LoginScreen(),
        //           ),
        //         ),
        //       );

        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute<LoginScreen>(
        //     builder: (_) => BlocProvider.value(
        //       value: authBloc,
        //       child: const LoginScreen(),
        //     ),
        //   ),
        //   (Route<dynamic> route) => false,
        // );
        //     }
        //     if (state is AuthAuthenticated) {
        //       Navigator.of(context).push(
        //         MaterialPageRoute<LoginScreen>(
        //           builder: (_) => BlocProvider.value(
        //             value: authBloc,
        //             child: const HomeScreen(),
        //           ),
        //         ),
        //         // (Route<dynamic> route) => false,
        //       );
        //     }
        //   },
        //   child: BlocBuilder<AuthBloc, AuthState>(
        //     bloc: authBloc,
        //     builder: (context, state) {
        //       if (state is AuthLoading) {
        //         return const Scaffold(
        //           body: Center(
        //             child: CircularProgressIndicator(),
        //           ),
        //         );
        //       }

        //       return Center(
        //         child: SizedBox(
        //           width: 40,
        //           height: 40,
        //           child: CircularProgressIndicator(
        //             color: Colors.grey[300],
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),

        builder: EasyLoading.init(),
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
