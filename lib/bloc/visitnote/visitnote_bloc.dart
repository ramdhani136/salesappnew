// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/models/visitnotes_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'visitnote_event.dart';
part 'visitnote_state.dart';

class VisitnoteBloc extends Bloc<VisitnoteEvent, VisitnoteState> {
  String name = "";
  String notes = "";
  List<KeyValue> tags = [];
  VisitnoteBloc() : super(VisitnoteInitial()) {
    on<GetVisitNote>(
      (event, emit) => _GetData(event, emit, state),
    );
    on<ShowVisitNote>(
      (event, emit) => _ShowData(event, emit, state),
    );
    on<DeleteVisitNote>(
      (event, emit) => _DeleteData(event, emit, state),
    );
    on<UpdateVisitNote>(
      (event, emit) => _UpdateData(event, emit, state),
    );
    on<InsertVisitNote>(
      (event, emit) => _InsertData(event, emit, state),
    );
    on<VisitNoteAddTag>(
      (event, emit) {
        List<KeyValue> newTags = List<KeyValue>.from(tags);
        if (!newTags.any((element) => element.name == event.tag.name)) {
          newTags.add(event.tag);
        }
        tags = newTags;
        if (state is VisitNoteShow) {
          VisitNoteShow current = state as VisitNoteShow;
          emit(
            VisitNoteShow(data: current.data),
          );
        } else {
          emit(VisitnoteInitial());
        }
      },
    );
    on<VisitNoteRemoveTag>(
      (event, emit) {
        List<KeyValue> newTags = List<KeyValue>.from(tags);
        newTags.removeWhere((element) => element.name == event.tag.name);
        tags = newTags;
        if (state is VisitNoteShow) {
          VisitNoteShow current = state as VisitNoteShow;
          emit(
            VisitNoteShow(data: current.data),
          );
        } else {
          emit(VisitnoteInitial());
        }
      },
    );
  }

  Future<void> _GetData(
    GetVisitNote event,
    Emitter<VisitnoteState> emit,
    VisitnoteState state,
  ) async {
    try {
      int _page = 1;
      if (state is VisitNoteIsLoaded && !event.refresh) {
        _page = state.page;
        state.IsloadingPage = true;
        emit(
          VisitNoteIsLoaded(data: state.data, IsloadingPage: true),
        );
      } else {
        emit(VisitNoteIsLoading());
      }

      Map<String, dynamic> result =
          await FetchData(data: Data.visitnote).FINDALL(
        params: "/visit/${event.visitId}",
        page: _page,
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }

      List<VisitNoteModel> newData =
          VisitNoteModel.fromJsonList(result['data']);

      List<VisitNoteModel> currentData = [];
      if (state is VisitNoteIsLoaded && !event.refresh) {
        currentData = state.data;
        currentData.addAll(newData);
      } else {
        currentData = newData;
      }

      emit(
        VisitNoteIsLoaded(
          data: currentData,
          hasMore: result['hasMore'],
          total: result['total'],
          page: result['nextPage'],
          IsloadingPage: false,
        ),
      );
    } catch (e) {
      emit(
        VisitNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _ShowData(
    ShowVisitNote event,
    Emitter<VisitnoteState> emit,
    VisitnoteState state,
  ) async {
    try {
      if (event.isLoading) {
        emit(VisitNoteIsLoading());
      }
      dynamic result =
          await FetchData(data: Data.visitnote).FINDONE(id: event.id);
      if (result['status'] != 200) {
        throw result['msg'];
      }
      List<dynamic> tagsData = result['data']['tags'];
      tags = tagsData.map((item) {
        return KeyValue(name: item['name'], value: item['_id']);
      }).toList();

      emit(VisitNoteShow(data: result['data']));
    } catch (e) {
      emit(
        VisitNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _UpdateData(
    UpdateVisitNote event,
    Emitter<VisitnoteState> emit,
    VisitnoteState state,
  ) async {
    try {
      // emit(VisitNoteIsLoading());
      dynamic result = await FetchData(data: Data.visitnote).UPDATEONE(
        event.id,
        event.data,
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }

      Fluttertoast.showToast(
        msg: "Saved",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
      add(ShowVisitNote(
        id: event.id,
        isLoading: false,
      ));
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
      emit(
        VisitNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _DeleteData(
    DeleteVisitNote event,
    Emitter<VisitnoteState> emit,
    VisitnoteState state,
  ) async {
    try {
      emit(VisitNoteIsLoading());

      dynamic result =
          await FetchData(data: Data.visitnote).DELETEONE(event.id);
      if (result['status'] != 200) {
        throw result['msg'];
      }
      emit(VisitNoteDeleteSuccess());
    } catch (e) {
      emit(
        VisitNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _InsertData(
    InsertVisitNote event,
    Emitter<VisitnoteState> emit,
    VisitnoteState state,
  ) async {
    try {
      emit(VisitNoteIsLoading());
      dynamic result = await FetchData(data: Data.visitnote).ADD(
        event.data,
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }
      Fluttertoast.showToast(
        msg: "Saved",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );

      add(ShowVisitNote(
        id: result['data']['_id'],
        isLoading: false,
      ));
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text(e.toString()),

        // textConfirm: 'OK',
        // confirmTextColor: Colors.white,
        // onConfirm: () {
        //   Get.back();
        // },
      );
      emit(
        VisitNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }
}
