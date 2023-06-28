// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/bloc/visitnote/visitnote_bloc.dart';

class VisitFormResult extends StatelessWidget {
  String visitId;
  VisitFormResult({super.key, required this.visitId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitnoteBloc()
        ..add(GetVisitNote(
          visitId: visitId,
        )),
      child: BlocBuilder<VisitnoteBloc, VisitnoteState>(
        builder: (context, state) {
          VisitnoteBloc visitNoteBloc = BlocProvider.of<VisitnoteBloc>(context);

          if (state is VisitNoteIsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is VisitNoteIsLoaded) {
            return Scaffold(
              body: RefreshIndicator(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        state.hasMore) {
                      state.hasMore = false;
                      visitNoteBloc.add(
                        GetVisitNote(
                          visitId: visitId,
                          refresh: false,
                        ),
                      );
                    }
                    return false;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 20,
                    ),
                    child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.data[index].title),
                          subtitle: Text(state.data[index].notes),
                        );
                      },
                    ),
                  ),
                ),
                onRefresh: () async {
                  visitNoteBloc.add(
                    GetVisitNote(
                      visitId: visitId,
                    ),
                  );
                },
              ),
              floatingActionButton: BlocBuilder<VisitBloc, VisitState>(
                builder: (context, state) {
                  if (state is IsShowLoaded) {
                    return Visibility(
                      visible: state.data.status == "0",
                      child: SizedBox(
                        height: 70.0,
                        width: 60.0,
                        child: FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.grey[850],
                          child: const Icon(Icons.add),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
