import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/bloc/callsheet/callsheet_bloc.dart';
import 'package:salesappnew/screens/callsheet/widgets/callsheet_body_list.dart';

class CallsheetScreenBody extends StatefulWidget {
  final int status;
  final Color colorHeader;
  final Color colorFontHeader;

  const CallsheetScreenBody({
    Key? key,
    required this.status,
    required this.colorHeader,
    required this.colorFontHeader,
  }) : super(key: key);

  @override
  State<CallsheetScreenBody> createState() => __CallsheetScreenBodyStateState();
}

class __CallsheetScreenBodyStateState extends State<CallsheetScreenBody> {
  Timer? _debounceTimer;
  late TextEditingController _textEditingController;
  late CallsheetBloc callsheetBloc;

  @override
  void initState() {
    super.initState();
    callsheetBloc = BlocProvider.of<CallsheetBloc>(context);

    _textEditingController = TextEditingController(text: callsheetBloc.search);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callsheetBloc.add(CallsheetGetAllData(
        status: widget.status,
        getRefresh: true,
        search: _textEditingController.text,
      ));
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String searchText) {
    callsheetBloc.add(CallsheetChangeSearch(searchText));

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      callsheetBloc.add(CallsheetGetAllData(
        status: widget.status,
        getRefresh: true,
        search: searchText,
      ));
    });
  }

  void _clearSearchText() {
    callsheetBloc.add(CallsheetChangeSearch(""));
    _textEditingController.text = "";
    callsheetBloc.add(CallsheetGetAllData(
      status: widget.status,
      getRefresh: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallsheetBloc, CallsheetState>(
      listener: (context, state) {
        callsheetBloc.tabActive = widget.status;
        if (state is CallsheetDeleteSuccess) {
          callsheetBloc.add(CallsheetGetAllData(
            status: widget.status,
            getRefresh: true,
            search: _textEditingController.text,
          ));
        }
        if (state is CallsheetTokenExpired) {
          if (state.error ==
              "Forbiden, you have to login to access the data!") {
            BlocProvider.of<AuthBloc>(context).add(OnLogout());
          }
        }
        if (state is CallsheetDeleteFailure) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey[800],
            textColor: Colors.white,
          );
          callsheetBloc.add(CallsheetGetAllData(
            status: widget.status,
            getRefresh: true,
            search: _textEditingController.text,
          ));
        }
      },
      builder: (context, state) {
        if (state is CallsheetIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CallsheetIsLoaded) {
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
                        visible: callsheetBloc.search != "",
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
                      callsheetBloc.add(CallsheetGetAllData(
                        status: widget.status,
                        getRefresh: true,
                        search: _textEditingController.text,
                      ));
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                            state.hasMore) {
                          state.pageLoading = true;
                          state.hasMore = false;
                          callsheetBloc.add(CallsheetGetAllData(
                            status: callsheetBloc.tabActive ?? 1,
                            search: _textEditingController.text,
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
                                        return CallsheetBodyList(
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
