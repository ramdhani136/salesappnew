// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesappnew/models/dn_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'dn_event.dart';
part 'dn_state.dart';

class DnBloc extends Bloc<DnEvent, DnState> {
  String search = "";
  int page = 1;
  int? tabActive;
  DnBloc() : super(DnInitial()) {
    on<GetDnShow>(_ShowData);
    on<DnGetAll>(_GetAllData);
    on<DnChangeSearch>((event, emit) async {
      search = event.search;
    });
  }

  Future<void> _GetAllData(DnGetAll event, Emitter<DnState> emit) async {
    try {
      int page = 1;
      if (state is! DnIsLoaded || event.getRefresh) {
        emit(DnIsLoading());
      } else {
        DnIsLoaded current = state as DnIsLoaded;
        emit(
          DnIsLoaded(
            data: current.data,
            hasMore: current.hasMore,
            pageLoading: true,
          ),
        );
      }

      List<List<String>> filters = [
        [
          "docstatus",
          "=",
          "${event.status}",
        ],
      ];

      if (event.search != "" && event.search != null) {
        filters.add(["name", "like", "${event.search}"]);
      }

      Map<String, dynamic> getData = await FetchData(data: Data.erp).FINDALL(
        page: event.getRefresh ? 1 : page,
        params: "/Delivery Note",
        fields: [
          "customer",
          "name",
          "modified",
          "owner",
          "customer_group",
          "workflow_state",
          "docstatus",
          "grand_total",
          "per_billed"
        ],
        filters: filters,
      );

      if (getData['status'] == 200) {
        page = getData['nextPage'];
        List response = getData['data'];

        List currentData = [];
        if (state is DnIsLoaded && !event.getRefresh) {
          currentData = (state as DnIsLoaded).data;
          currentData.addAll(response);
        } else {
          currentData = response;
        }

        emit(
          DnIsLoaded(
            data: currentData,
            hasMore: getData['hasMore'],
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

        emit(DnTokenExpired(getData['msg']));
      } else {
        List visitList = [];
        emit(
          DnIsLoaded(
            data: visitList,
            hasMore: false,
            pageLoading: false,
          ),
        );
        throw (getData['msg']);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
      page = 1;
      // emit(DnIsFailure(e.toString()));
    }
  }

  Future<void> _ShowData(
    GetDnShow event,
    Emitter<DnState> emit,
  ) async {
    try {
      emit(DnIsLoading());
      Map<String, dynamic> result = await FetchData(data: Data.erp).FINDONE(
        id: event.id,
        params: "/Delivery Note",
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }
      DnModel data = DnModel.fromJson(result['data']);
      List<dynamic> action = result['workflow'];

      emit(DnShowIsLoaded(data: data, workflow: action));
    } catch (e) {
      emit(DnIsFailure(e.toString()));
    }
  }
}
