import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';

class VisitFormResult extends StatelessWidget {
  const VisitFormResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              print("refresh");
              // stateInv.hasMore = false;
              // BlocProvider.of<InvoiceBloc>(context).add(
              //   InvoiceGetOverDue(
              //       customerId: state.data.customer!.erpId!,
              //       loadingPage: false),
              // );
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
              itemCount: 50,
              itemBuilder: (context, index) {
                return Text("Halo");
              },
            ),
          ),
        ),
        onRefresh: () async {},
      ),
      floatingActionButton: BlocBuilder<VisitBloc, VisitState>(
        builder: (context, state) {
          if (state is IsShowLoaded) {
            return Visibility(
              visible: state.data.checkOut == null,
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
}
