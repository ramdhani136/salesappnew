import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/screens/visit/widgets/visit_body_list.dart';

class VisitBody extends StatelessWidget {
  IsLoaded state;
  VisitBody(this.state);

  @override
  Widget build(BuildContext context) {
    bool hasMore = true;

    final VisitBloc visitBloc = context.read<VisitBloc>();

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
                      hasMore) {
                    print("loadmore");
                  }

                  return false;
                },
                child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return VisitBodyList(state.data[index]);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
