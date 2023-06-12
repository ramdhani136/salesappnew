import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/screens/login_screen.dart';
// import 'package:salesappnew/bloc/color_bloc2.dart';
// import 'package:salesappnew/screens/latihan/latihan2_screen.dart';
// import 'package:salesappnew/screens/latihan/latihan_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
