// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salesappnew/models/callsheetnote_model.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'callsheetnote_event.dart';
part 'callsheetnote_state.dart';

class CallsheetnoteBloc extends Bloc<CallsheetnoteEvent, CallsheetnoteState> {
  String name = "";
  String notes = "";
  List<KeyValue> tags = [];
  CallsheetnoteBloc() : super(CallsheetnoteInitial()) {
    on<GetCallsheetNote>(
      (event, emit) => _GetData(event, emit, state),
    );
    on<ShowCallsheetNote>(
      (event, emit) => _ShowData(event, emit, state),
    );
    on<DeleteCallsheetNote>(
      (event, emit) => _DeleteData(event, emit, state),
    );
    on<UpdateCallsheetNote>(
      (event, emit) => _UpdateData(event, emit, state),
    );
    on<InsertCallsheetNote>(
      (event, emit) => _InsertData(event, emit, state),
    );
    on<CallsheetNoteAddTag>(
      (event, emit) {
        List<KeyValue> newTags = List<KeyValue>.from(tags);
        if (!newTags.any((element) => element.name == event.tag.name)) {
          newTags.add(event.tag);
        }
        tags = newTags;
        if (state is CallsheetNoteShow) {
          CallsheetNoteShow current = state as CallsheetNoteShow;
          emit(
            CallsheetNoteShow(data: current.data),
          );
        } else {
          emit(CallsheetnoteInitial());
        }
      },
    );
    on<CallsheetNoteRemoveTag>(
      (event, emit) {
        List<KeyValue> newTags = List<KeyValue>.from(tags);
        newTags.removeWhere((element) => element.name == event.tag.name);
        tags = newTags;
        if (state is CallsheetNoteShow) {
          CallsheetNoteShow current = state as CallsheetNoteShow;
          emit(
            CallsheetNoteShow(data: current.data),
          );
        } else {
          emit(CallsheetnoteInitial());
        }
      },
    );
  }

  Future<void> _GetData(
    GetCallsheetNote event,
    Emitter<CallsheetnoteState> emit,
    CallsheetnoteState state,
  ) async {
    try {
      int _page = 1;
      if (state is CallsheetNoteIsLoaded && !event.refresh) {
        _page = state.page;
        state.IsloadingPage = true;
        emit(
          CallsheetNoteIsLoaded(data: state.data, IsloadingPage: true),
        );
      } else {
        emit(CallsheetNoteIsLoading());
      }

      Map<String, dynamic> result =
          await FetchData(data: Data.callsheetNote).FINDALL(
        params: "/callsheet/${event.callsheetId}",
        page: _page,
      );

      print(result);

      if (result['status'] != 200) {
        throw result['msg'];
      }

      List<CallsheetNoteModel> newData =
          CallsheetNoteModel.fromJsonList(result['data']);

      List<CallsheetNoteModel> currentData = [];
      if (state is CallsheetNoteIsLoaded && !event.refresh) {
        currentData = state.data;
        currentData.addAll(newData);
      } else {
        currentData = newData;
      }

      emit(
        CallsheetNoteIsLoaded(
          data: currentData,
          hasMore: result['hasMore'],
          total: result['total'],
          page: result['nextPage'],
          IsloadingPage: false,
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
      emit(
        CallsheetNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _ShowData(
    ShowCallsheetNote event,
    Emitter<CallsheetnoteState> emit,
    CallsheetnoteState state,
  ) async {
    try {
      if (event.isLoading) {
        emit(CallsheetNoteIsLoading());
      }
      dynamic result =
          await FetchData(data: Data.callsheetNote).FINDONE(id: event.id);
      if (result['status'] != 200) {
        throw result['msg'];
      }
      List<dynamic> tagsData = result['data']['tags'];
      tags = tagsData.map((item) {
        return KeyValue(name: item['name'], value: item['_id']);
      }).toList();

      emit(CallsheetNoteShow(data: result['data']));
    } catch (e) {
      emit(
        CallsheetNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _UpdateData(
    UpdateCallsheetNote event,
    Emitter<CallsheetnoteState> emit,
    CallsheetnoteState state,
  ) async {
    try {
      // emit(CallsheetNoteIsLoading());
      dynamic result = await FetchData(data: Data.callsheetNote).UPDATEONE(
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
      add(ShowCallsheetNote(
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
        CallsheetNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _DeleteData(
    DeleteCallsheetNote event,
    Emitter<CallsheetnoteState> emit,
    CallsheetnoteState state,
  ) async {
    try {
      emit(CallsheetNoteIsLoading());

      dynamic result =
          await FetchData(data: Data.callsheetNote).DELETEONE(event.id);
      if (result['status'] != 200) {
        throw result['msg'];
      }
      emit(CallsheetNoteDeleteSuccess());
    } catch (e) {
      emit(
        CallsheetNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _InsertData(
    InsertCallsheetNote event,
    Emitter<CallsheetnoteState> emit,
    CallsheetnoteState state,
  ) async {
    try {
      emit(CallsheetNoteIsLoading());
      dynamic result = await FetchData(data: Data.callsheetNote).ADD(
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

      add(ShowCallsheetNote(
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
        CallsheetNoteIsFailure(
          e.toString(),
        ),
      );
    }
  }
}
