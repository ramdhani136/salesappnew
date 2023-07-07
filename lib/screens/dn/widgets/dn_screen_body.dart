import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/bloc/dn/dn_bloc.dart';
import 'package:salesappnew/screens/dn/widgets/dn_body_list.dart';

class DnScreenBody extends StatefulWidget {
  final int status;
  final Color colorHeader;
  final Color colorFontHeader;

  const DnScreenBody({
    Key? key,
    required this.status,
    required this.colorHeader,
    required this.colorFontHeader,
  }) : super(key: key);

  @override
  State<DnScreenBody> createState() => __DnScreenBodyStateState();
}

class __DnScreenBodyStateState extends State<DnScreenBody> {
  Timer? _debounceTimer;
  late TextEditingController _textEditingController;
  late DnBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DnBloc>(context);

    _textEditingController = TextEditingController(text: bloc.search);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(DnGetAll(
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
    bloc.add(DnChangeSearch(searchText));

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      bloc.add(DnGetAll(
        status: widget.status,
        getRefresh: true,
        search: searchText,
      ));
    });
  }

  void _clearSearchText() {
    bloc.add(DnChangeSearch(""));
    _textEditingController.text = "";
    bloc.add(DnGetAll(
      status: widget.status,
      getRefresh: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DnBloc, DnState>(
      listener: (context, state) {
        bloc.tabActive = widget.status;

        if (state is DnTokenExpired) {
          if (state.error ==
              "Forbiden, you have to login to access the data!") {
            BlocProvider.of<AuthBloc>(context).add(OnLogout());
          }
        }
      },
      builder: (context, state) {
        if (state is DnIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DnIsLoaded) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
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
                        visible: bloc.search != "",
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
                      bloc.add(DnGetAll(
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
                          bloc.add(DnGetAll(
                            status: bloc.tabActive ?? 1,
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
                                        return DnBodyList(
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
