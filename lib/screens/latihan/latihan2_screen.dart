import 'package:flutter/material.dart';
import 'package:salesappnew/bloc/color_bloc2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Latihan2Screen extends StatefulWidget {
  const Latihan2Screen({super.key});

  @override
  State<Latihan2Screen> createState() => _LatihanScreenState();
}

class _LatihanScreenState extends State<Latihan2Screen> {
  @override
  Widget build(BuildContext context) {
    // ColorBloc bloc = BlocProvider.of<ColorBloc>(context);
    return Scaffold(
      body: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<ColorBloc>().add(ColorEvent.ColorToAmberEvent);
              },
              backgroundColor: Colors.amber,
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                context.read<ColorBloc>().add(ColorEvent.ColorToBlueEvent);
              },
              backgroundColor: Colors.lightBlue,
            ),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Flutter Bloc"),
        ),
        body: Center(child: BlocBuilder<ColorBloc, Color>(
          builder: (context, state) {
            return AnimatedContainer(
              width: 100,
              height: 100,
              color: state,
              duration: const Duration(milliseconds: 500),
            );
          },
        )),
      ),
    );
  }
}
