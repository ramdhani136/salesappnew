import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';

class VisitFormInfo extends StatelessWidget {
  const VisitFormInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        VisitBloc visitBloc = BlocProvider.of<VisitBloc>(context);
        if (state is IsLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 150),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is IsShowLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              visitBloc.add(ShowData("${state.data.id}"));
            },
            child: ListView(
              children: [
                Text("${state.data.name}"),
                Text("${state.data.checkIn!.lat}"),
                Text("${state.data.checkIn!.lng}"),
                Text(
                  "Dua",
                )
              ],
            ),
          );
        }
        return Center(
          child: Text("No data"),
        );
      },
    );
  }
}
