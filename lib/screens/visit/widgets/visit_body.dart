import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/screens/visit/widgets/visit_body_list.dart';

class VisitBody extends StatefulWidget {
  VisitBody();

  @override
  State<VisitBody> createState() => _VisitBodyState();
}

class _VisitBodyState extends State<VisitBody> {
  @override
  void initState() {
    super.initState();
    context.read<VisitBloc>().add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    VisitBloc visitBloc = context.read<VisitBloc>();

    return BlocBuilder<VisitBloc, VisitState>(builder: (context, state) {
      if (state is IsLoading) {
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (state is IsFailure) {}

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
                        print("push");
                        visitBloc.add(GetData());
                      }

                      return false;
                    },
                    child: Stack(
                      children: [
                        ListView.builder(
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return VisitBodyList(state.data[index]);
                          },
                        ),
                        Visibility(
                          visible: visitBloc.pageLoading,
                          child: Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ),
                              ),
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
