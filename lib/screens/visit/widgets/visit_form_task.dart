// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';

class VisitFormTask extends StatelessWidget {
  const VisitFormTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        VisitBloc visitBloc = BlocProvider.of<VisitBloc>(context);

        if (state is IsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is IsShowLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              visitBloc.add(ShowData(id: "${state.data.id}"));
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: state.task.length,
                itemBuilder: (context, index) {
                  return Text(state.task[index].name);
                },
              ),
            ),
          );
        }
        return const Center(
          child: Text(
            "No Task",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
