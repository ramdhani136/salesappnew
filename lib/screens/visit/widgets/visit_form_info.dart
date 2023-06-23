import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VisitFormInfo extends StatelessWidget {
  const VisitFormInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PanelController _panelController = PanelController();
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        VisitBloc visitBloc = BlocProvider.of<VisitBloc>(context);
        if (state is IsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is IsShowLoaded) {
          return SlidingUpPanel(
            controller: _panelController,
            defaultPanelState: PanelState.CLOSED,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            parallaxEnabled: true,
            maxHeight: Get.height / 2,
            minHeight: 30,
            panel: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _panelController.isPanelOpen
                            ? _panelController.close()
                            : _panelController.open();
                      },
                      child: Container(
                        width: 30,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        itemCount: state.history.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color.fromARGB(
                                      255, 239, 237, 237), // Warna border
                                  width: 1.0, // Ketebalan border
                                ),
                              ),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.history[index].user.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        DateFormat.yMd().add_jm().format(
                                              DateTime.parse(
                                                      "${state.history[index].createdAt}")
                                                  .toLocal(),
                                            ),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Text(state.history[index].message),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                visitBloc.add(ShowData("${state.data.id}"));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
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
              ),
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
