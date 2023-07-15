// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesappnew/models/group_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  int page = 1;
  String search = "";
  GroupBloc() : super(GroupInitial()) {
    on<GroupGetData>(_GetAllData);
    on<GroupChangeSearch>((event, emit) async {
      search = event.search;
    });
  }

  Future<void> _GetAllData(GroupGetData event, Emitter<GroupState> emit) async {
    try {
      search = event.search;

      if (event.getRefresh) {
        emit(GroupIsLoading());
        EasyLoading.show(status: 'loading...');
      } else {
        GroupIsLoaded current = state as GroupIsLoaded;
        emit(
          GroupIsLoaded(
            data: current.data,
            hasMore: current.hasMore,
            total: current.total,
            pageLoading: true,
          ),
        );
      }

      Map<String, dynamic> getData =
          await FetchData(data: Data.customergroup).FINDALL(
        page: event.getRefresh ? 1 : page,
        filters: event.filters ?? [],
        search: event.search,
      );

      if (getData['status'] == 200) {
        page = getData['nextPage'];
        List<GroupModel> visitList = GroupModel.fromJsonList(getData['data']);

        List<GroupModel> currentData = [];
        if (state is GroupIsLoaded && !event.getRefresh) {
          currentData = (state as GroupIsLoaded).data;
          currentData.addAll(visitList);
        } else {
          currentData = visitList;
        }

        emit(
          GroupIsLoaded(
            data: currentData,
            hasMore: getData['hasMore'],
            total: getData['total'],
            pageLoading: false,
          ),
        );
      } else if (getData['status'] == 403) {
        Fluttertoast.showToast(
          msg: getData['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
        );

        emit(GroupTokenExpired(getData['msg']));
      } else {
        page = 1;
        List<GroupModel> visitList = GroupModel.fromJsonList([]);

        emit(
          GroupIsLoaded(
            data: visitList,
            hasMore: false,
            total: 0,
            pageLoading: false,
          ),
        );
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      emit(GroupIsFailure(e.toString()));
    }
  }
}
