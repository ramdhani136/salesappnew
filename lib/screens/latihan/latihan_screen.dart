import 'package:flutter/material.dart';
import 'package:salesappnew/bloc/color_bloc.dart';

class LatihanScreen extends StatefulWidget {
  const LatihanScreen({super.key});

  @override
  State<LatihanScreen> createState() => _LatihanScreenState();
}

class _LatihanScreenState extends State<LatihanScreen> {
  ColorBloc bloc = ColorBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                bloc.eventSink.add(ColorEvent.toAmber);
              },
              backgroundColor: Colors.amber,
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                bloc.eventSink.add(ColorEvent.toLightBlue);
              },
              backgroundColor: Colors.lightBlue,
            ),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Flutter Bloc"),
        ),
        body: Center(
            child: StreamBuilder<Color>(
          stream: bloc.stateStream,
          initialData: Colors.amber,
          builder: (context, snapshot) {
            return AnimatedContainer(
              width: 100,
              height: 100,
              color: snapshot.data,
              duration: const Duration(milliseconds: 500),
            );
          },
        )),
      ),
    );
  }
}
