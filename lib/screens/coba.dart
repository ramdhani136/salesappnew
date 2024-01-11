import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/gps/gps_bloc.dart';

class Coba extends StatelessWidget {
  const Coba({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<GpsBloc, GpsState>(
      bloc: GpsBloc()..add(GpsGetLocation()),
      builder: (context, state) {
        return Text("ddd");
      },
    ));
  }
}
