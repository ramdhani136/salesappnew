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

  runApp(const MyApp());
  configLoading();
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
        routes: {
          '/visit': (context) => const VisitScreen(),
          '/callsheet': (context) => const CallsheetScreen(),
          '/home': (context) => const HomeScreen(),
          '/dn': (context) => const DnScreen(),
          '/invoice': (context) => const InvoiceScreen(),
          '/so': (context) => const OrderScreen(),
          '/item': (context) => const ItemScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
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
