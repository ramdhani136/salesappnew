// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, unnecessary_import

import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/models/history_model.dart';
import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/models/action_model.dart';
import 'package:signature/signature.dart';
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  int _page = 1;
  String search = "";
  AuthBloc authBloc = AuthBloc(AuthRepository());
  Position? checkOutCordinates;
  String? checkOutAddress;
  int? tabActive;
  Uint8List? signature;

  VisitBloc() : super(VisitInitial()) {
    on<GetData>(_GetAllData);
    on<ChangeSearch>((event, emit) async {
      search = event.search;
    });
    on<DeleteOne>(_DeleteOne);
    on<ShowData>(_ShowData);
    on<ChangeWorkflow>(_ChangeWorkflow);
    on<SetCheckOut>(_SetCheckOut);
    on<UpdateSignature>(_exportSignature);
    on<ClearSignature>(
      (event, emit) {
        signature = null;
        add(ShowData(
          id: event.id,
          isLoading: false,
        ));
      },
    );
  }

  Future<Uint8List?> _exportSignature(
      UpdateSignature event, Emitter<VisitState> emit) async {
    try {
      final exportController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white,
        points: event.controller.points,
      );

      final isSignature = await exportController.toPngBytes();
      exportController.dispose();

      signature = isSignature;
      add(ShowData(
        id: event.id,
        isLoading: false,
      ));
    } catch (e) {
      rethrow;
    }
    return null;
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

      add(ShowData(id: event.id));
    } catch (e) {
      emit(IsFailure(e.toString()));
      add(ShowData(id: event.id));
    }
  }

  Future<void> _SetCheckOut(SetCheckOut event, Emitter<VisitState> emit) async {
    try {
      emit(IsLoading());
      dynamic data = await FetchData(data: Data.visit).Update(
        event.id,
        {
          "signature": base64.encode(signature!),
          "checkOutLat": checkOutCordinates!.latitude,
          "checkOutLng": checkOutCordinates!.longitude
        },
      );

      if (data['status'] != 200) {
        throw data['msg'];
      }

      add(ShowData(id: event.id, isLoading: false));
    } catch (e) {
      emit(IsFailure(e.toString()));
      add(ShowData(id: event.id, isLoading: false));
    }
  }

  Future<void> _ShowData(ShowData event, Emitter<VisitState> emit) async {
    try {
      if (event.isLoading) {
        emit(IsLoading());
      }
      Map<String, dynamic> data = await FetchData(data: Data.visit).Show(
        event.id,
      );

      Visitmodel result = Visitmodel.fromJson(data['data']);

      List<ActionModel> action = ActionModel.fromJsonList(data['workflow']);
      List<HistoryModel> history = HistoryModel.fromJsonList(data['history']);

      if ((data['status']) != 200) {
        throw data['msg'];
      }

      emit(IsShowLoaded(
        data: result,
        workflow: action,
        history: history,
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

      print(event.status);

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
