// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/models/action_model.dart';
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  int _page = 1;
  String search = "";
  AuthBloc authBloc = AuthBloc(AuthRepository());

  VisitBloc() : super(VisitInitial()) {
    on<GetData>(_GetAllData);
    on<ChangeSearch>((event, emit) async {
      search = event.search;
    });
    on<DeleteOne>(_DeleteOne);
    on<ShowData>(_ShowData);
    on<ChangeWorkflow>(_ChangeWorkflow);
  }

  Future<void> _DeleteOne(DeleteOne event, Emitter<VisitState> emit) async {
    try {
      dynamic data = await FetchData(data: Data.visit).Delete(event.id);
      if ((data['status']) != 200) {
        throw data['msg'];
      }
      emit(DeleteSuccess());
    } catch (e) {
      emit(DeleteFailure(e.toString()));
    }
  }

  Future<void> _ChangeWorkflow(
      ChangeWorkflow event, Emitter<VisitState> emit) async {
    try {
      emit(IsLoading());
      dynamic data = await FetchData(data: Data.visit).Update(
        event.id,
        {"nextState": event.nextStateId},
      );

      if (data['status'] != 200) {
        throw data['msg'];
      }

      add(ShowData(event.id));
    } catch (e) {
      emit(IsFailure(e.toString()));
      add(ShowData(event.id));
    }
  }

  Future<void> _ShowData(ShowData event, Emitter<VisitState> emit) async {
    try {
      emit(IsLoading());
      Map<String, dynamic> data = await FetchData(data: Data.visit).Show(
        event.id,
      );

      Visitmodel result = Visitmodel.fromJson(data['data']);

      List<ActionModel> action = ActionModel.fromJsonList(data['workflow']);

      if ((data['status']) != 200) {
        throw data['msg'];
      }

      emit(IsShowLoaded(
        data: result,
        workflow: action,
      ));
    } catch (e) {
      emit(IsFailure(e.toString()));
    }
  }

  Future<void> _GetAllData(GetData event, Emitter<VisitState> emit) async {
    try {
      if (state is! IsLoaded || event.getRefresh) {
        emit(IsLoading());
      } else {
        IsLoaded current = state as IsLoaded;
        emit(
          IsLoaded(
            newData: current.data,
            hasMore: current.hasMore,
            total: current.total,
            pageLoading: true,
          ),
        );
      }

      Map<String, dynamic> getData = await FetchData(data: Data.visit).FIND(
          page: event.getRefresh ? 1 : _page,
          filters: [
            [
              "status",
              "=",
              "${event.status}",
            ]
          ],
          search: event.search);

      if (getData['status'] == 200) {
        _page = getData['nextPage'];
        List<Visitmodel> visitList = Visitmodel.fromJsonList(getData['data']);

        List<Visitmodel> currentData = [];
        if (state is IsLoaded && !event.getRefresh) {
          currentData = (state as IsLoaded).data;
          currentData.addAll(visitList);
        } else {
          currentData = visitList;
        }

        emit(
          IsLoaded(
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

        emit(TokenExpired(getData['msg']));
      } else {
        _page = 1;
        List<Visitmodel> visitList = Visitmodel.fromJsonList([]);

        emit(
          IsLoaded(
            newData: visitList,
            hasMore: false,
            total: 0,
            pageLoading: false,
          ),
        );
      }
    } catch (e) {
      emit(IsFailure(e.toString()));
    }
  }
}
