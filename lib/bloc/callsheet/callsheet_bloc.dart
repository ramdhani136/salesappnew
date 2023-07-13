// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesappnew/models/action_model.dart';
import 'package:salesappnew/models/task_callsheet_model.dart';
import 'package:salesappnew/models/history_model.dart';
import 'package:salesappnew/models/callsheet_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'callsheet_event.dart';
part 'callsheet_state.dart';

class CallsheetBloc extends Bloc<CallsheetEvent, CallsheetState> {
  int page = 1;
  String search = "";
  int? tabActive;
  CallsheetBloc() : super(CallsheetInitial()) {
    on<CallsheetGetAllData>(_GetAllData);
    on<CallsheetDeleteOne>(_DeleteOne);
    on<CallsheetShowData>(_ShowData);

    on<CallsheetChangeWorkflow>(_ChangeWorkflow);
    // on<CallsheetInsert>(_PostData);
    on<CallsheetChangeSearch>((event, emit) async {
      search = event.search;
    });
  }

  Future<void> _ChangeWorkflow(
      CallsheetChangeWorkflow event, Emitter<CallsheetState> emit) async {
    try {
      emit(CallsheetIsLoading());
      dynamic data = await FetchData(data: Data.visit).UPDATEONE(
        event.id,
        {"nextState": event.nextStateId},
      );

      if (data['status'] != 200) {
        throw data['msg'];
      }

      add(CallsheetShowData(id: event.id));
    } catch (e) {
      emit(CallsheetIsFailure(e.toString()));
      add(CallsheetShowData(id: event.id));
    }
  }

  Future<void> _ShowData(
    CallsheetShowData event,
    Emitter<CallsheetState> emit,
  ) async {
    try {
      if (event.isLoading) {
        emit(CallsheetIsLoading());
      }
      Map<String, dynamic> data = await FetchData(data: Data.callsheet).FINDONE(
        id: event.id,
      );

      CallsheetModel result = CallsheetModel.fromJson(data['data']);

      List<ActionModel> action = ActionModel.fromJsonList(data['workflow']);
      List<HistoryModel> history = HistoryModel.fromJsonList(data['history']);

      List<TaskCallsheetModel> task =
          TaskCallsheetModel.fromJsonList(data['data']['taskNotes']);

      if ((data['status']) != 200) {
        throw data['msg'];
      }

      emit(CallsheetIsShowLoaded(
        data: result,
        workflow: action,
        history: history,
        task: task,
      ));
    } catch (e) {
      emit(CallsheetIsFailure(e.toString()));
    }
  }

  Future<void> _DeleteOne(
      CallsheetDeleteOne event, Emitter<CallsheetState> emit) async {
    try {
      dynamic data = await FetchData(data: Data.callsheet).DELETEONE(event.id);
      if ((data['status']) != 200) {
        throw data['msg'];
      }
      emit(CallsheetDeleteSuccess());
    } catch (e) {
      emit(CallsheetDeleteFailure(e.toString()));
    }
  }

  Future<void> _GetAllData(
    CallsheetGetAllData event,
    Emitter<CallsheetState> emit,
  ) async {
    try {
      if (state is! CallsheetIsLoaded || event.getRefresh) {
        emit(CallsheetIsLoading());
      } else {
        CallsheetIsLoaded current = state as CallsheetIsLoaded;
        emit(
          CallsheetIsLoaded(
            newData: current.data,
            hasMore: current.hasMore,
            total: current.total,
            pageLoading: true,
          ),
        );
      }

      Map<String, dynamic> getData =
          await FetchData(data: Data.callsheet).FINDALL(
              page: event.getRefresh ? 1 : page,
              filters: [
                [
                  "status",
                  "=",
                  "${event.status}",
                ]
              ],
              search: event.search);

      if (getData['status'] == 200) {
        page = getData['nextPage'];
        List<CallsheetModel> response =
            CallsheetModel.fromJsonList(getData['data']);

        List<CallsheetModel> currentData = [];
        if (state is CallsheetIsLoaded && !event.getRefresh) {
          currentData = (state as CallsheetIsLoaded).data;
          currentData.addAll(response);
        } else {
          currentData = response;
        }

        emit(
          CallsheetIsLoaded(
            newData: currentData,
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

        emit(CallsheetTokenExpired(getData['msg']));
      } else {
        page = 1;
        List<CallsheetModel> data = CallsheetModel.fromJsonList([]);

        emit(
          CallsheetIsLoaded(
            newData: data,
            hasMore: false,
            total: 0,
            pageLoading: false,
          ),
        );
      }
    } catch (e) {
      emit(CallsheetIsFailure(e.toString()));
    }
  }
}
