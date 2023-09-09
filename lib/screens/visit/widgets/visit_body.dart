import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/visit/widgets/visit_body_list.dart';

class VisitBody extends StatefulWidget {
  final int status;
  final Color colorHeader;
  final Color colorFontHeader;

  const VisitBody({
    Key? key,
    required this.status,
    required this.colorHeader,
    required this.colorFontHeader,
  }) : super(key: key);

  @override
  State<VisitBody> createState() => _VisitBodyState();
}

class _VisitBodyState extends State<VisitBody> {
  Timer? _debounceTimer;
  late TextEditingController _textEditingController;
  late VisitBloc visitBloc;

  @override
  void initState() {
    super.initState();
    visitBloc = BlocProvider.of<VisitBloc>(context);

    _textEditingController = TextEditingController(text: visitBloc.search);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      visitBloc.add(GetData(
        status: widget.status,
        getRefresh: true,
        search: _textEditingController.text,
        filters: visitBloc.filters,
      ));
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String searchText) {
    visitBloc.add(ChangeSearch(searchText));

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      visitBloc.add(GetData(
        status: widget.status,
        getRefresh: true,
        search: searchText,
        filters: visitBloc.filters,
      ));
    });
  }

  void _clearSearchText() {
    visitBloc.add(ChangeSearch(""));
    _textEditingController.text = "";
    visitBloc.add(GetData(
      status: widget.status,
      filters: visitBloc.filters ?? [],
      getRefresh: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitBloc, VisitState>(
      listener: (context, state) {
        visitBloc.tabActive = widget.status;
        if (state is DeleteSuccess) {
          visitBloc.add(GetData(
            status: widget.status,
            getRefresh: true,
            search: _textEditingController.text,
            filters: visitBloc.filters,
          ));
        }
        if (state is TokenExpired) {
          if (state.error ==
              "Forbiden, you have to login to access the data!") {
            BlocProvider.of<AuthBloc>(context).add(OnLogout());
          }
        }
        if (state is DeleteFailure) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey[800],
            textColor: Colors.white,
          );
          visitBloc.add(GetData(
            status: widget.status,
            getRefresh: true,
            search: _textEditingController.text,
            filters: visitBloc.filters,
          ));
        }
      },
      builder: (context, state) {
        if (state is IsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is IsLoaded) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${state.data.length} of ${state.total}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _textEditingController,
                  onChanged: _onSearchTextChanged,
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
                      onPressed: _clearSearchText,
                      icon: Visibility(
                        visible: visitBloc.search != "",
                        child: Icon(
                          Icons.close,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 230, 228, 228),
                          width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 69, 69, 69), width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      visitBloc.add(GetData(
                        status: widget.status,
                        getRefresh: true,
                        search: _textEditingController.text,
                        filters: visitBloc.filters,
                      ));
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                            state.hasMore) {
                          state.pageLoading = true;
                          state.hasMore = false;
                          visitBloc.add(GetData(
                            status: visitBloc.tabActive ?? 1,
                            search: _textEditingController.text,
                            filters: visitBloc.filters,
                          ));
                        }
                        return false;
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: state.data.isEmpty,
                                  child: const Padding(
                                    padding: EdgeInsets.only(bottom: 50),
                                    child: Center(
                                      child: Text(
                                        "Data not found",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: state.data.isNotEmpty,
                                  child: Expanded(
                                    child: ListView.builder(
                                      itemCount: state.data.length,
                                      itemBuilder: (context, index) {
                                        return VisitBodyList(
                                          data: state.data[index],
                                          colorFontHeader:
                                              widget.colorFontHeader,
                                          colorHeader: widget.colorHeader,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: state.pageLoading,
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 60),
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

        return const Center(
          child: Text(
            "Data Not Found!",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
