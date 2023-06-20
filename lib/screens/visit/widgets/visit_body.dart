import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_body_list.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class VisitBody extends StatelessWidget {
  int status;
  VisitBody({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    VisitBloc visitBloc = context.read<VisitBloc>();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      visitBloc.add(GetData(status: status));
    });

    return BlocBuilder<VisitBloc, VisitState>(builder: (context, state) {
      // if (state is VisitInitial) {
      //   visitBloc.add(GetData());
      // }

      if (state is IsLoading) {
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (state is IsFailure) {
        print(state.error);
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Container(
              child: Text(
                "Not found data",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      }

      if (state is IsLoaded) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[300],
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 230, 228, 228), width: 1.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 69, 69, 69), width: 2.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    visitBloc.add(GetData());
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent &&
                          state.hasMore) {
                        state.pageLoading = true;
                        state.hasMore = false;
                        visitBloc.add(GetData());
                      }

                      return false;
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ListView.builder(
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              return VisitBodyList(state.data[index]);
                            },
                          ),
                        ),
                        Visibility(
                          visible: state.pageLoading,
                          child: const Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
      return Container();
    });
  }
}
