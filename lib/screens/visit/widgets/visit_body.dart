// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';

import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/screens/login_screen.dart';

import 'package:salesappnew/screens/visit/widgets/visit_body_list.dart';

class VisitBody extends StatefulWidget {
  int status;
  Color colorHeader;
  Color colorFontHeader;
  VisitBody(
      {super.key,
      required this.status,
      required this.colorFontHeader,
      required this.colorHeader});

  @override
  State<VisitBody> createState() => _VisitBodyState();
}

class _VisitBodyState extends State<VisitBody> {
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    VisitBloc visitBloc = BlocProvider.of<VisitBloc>(context);

    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _textEditingController = TextEditingController(
      text: visitBloc.search,
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        visitBloc.add(
          GetData(
              status: widget.status,
              getRefresh: true,
              search: _textEditingController.text),
        );
      },
    );

    return BlocBuilder<VisitBloc, VisitState>(builder: (context, state) {
      if (state is IsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is DeleteSuccess) {
        visitBloc.add(
          GetData(
              status: widget.status,
              getRefresh: true,
              search: _textEditingController.text),
        );
      }

      if (state is TokenExpired) {
        BlocProvider.of<AuthBloc>(context).add(OnLogout());
      }

      if (state is DeleteFailure) {
        Fluttertoast.showToast(
          msg: state.error,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
        );
        visitBloc.add(
          GetData(
              status: widget.status,
              getRefresh: true,
              search: _textEditingController.text),
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
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _textEditingController,
                onChanged: (e) {
                  visitBloc.add(ChangeSearch(e));
                  // Batalkan timer sebelumnya jika ada
                  _debounceTimer?.cancel();

                  // Jalankan fungsi setelah pengguna berhenti mengetik selama 1 detik
                  _debounceTimer = Timer(const Duration(seconds: 1), () {
                    // Jalankan fungsi Anda di sini
                    visitBloc.add(
                      GetData(
                        status: widget.status,
                        getRefresh: true,
                        search: e,
                      ),
                    );
                  });
                },
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
                    onPressed: () {
                      visitBloc.add(ChangeSearch(""));
                      _textEditingController.text = "";
                      visitBloc.add(
                        GetData(
                          status: widget.status,
                          getRefresh: true,
                        ),
                      );
                    },
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
                    visitBloc.add(
                      GetData(
                          status: widget.status,
                          getRefresh: true,
                          search: _textEditingController.text),
                    );
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent &&
                          state.hasMore) {
                        state.pageLoading = true;
                        state.hasMore = false;
                        visitBloc.add(
                          GetData(search: _textEditingController.text),
                        );
                      }

                      return false;
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
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
                                        colorFontHeader: widget.colorFontHeader,
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
                            padding: EdgeInsets.only(bottom: 30),
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
      return Center(
        child: Container(
          child: Text(
            "Data Notfound!",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      );
    });
  }
}
