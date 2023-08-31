// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:meta/meta.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/models/note_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  String name = "";
  String notes = "";
  List<KeyValue> tags = [];
  NoteBloc() : super(NoteInitial()) {
    on<NoteGetData>(
      (event, emit) => _GetData(event, emit, state),
    );
    on<NoteShowData>(
      (event, emit) => _ShowData(event, emit, state),
    );
    on<NoteDeleteData>(
      (event, emit) => _DeleteData(event, emit, state),
    );
    on<NoteUpdateData>(
      (event, emit) => _UpdateData(event, emit, state),
    );
    on<NoteAddData>(
      (event, emit) => _InsertData(event, emit, state),
    );
    on<NoteAddTag>(
      (event, emit) {
        List<KeyValue> newTags = List<KeyValue>.from(tags);
        if (!newTags.any((element) => element.name == event.tag.name)) {
          newTags.add(event.tag);
        }
        tags = newTags;
        if (state is NoteShowIsLoaded) {
          NoteShowIsLoaded current = state as NoteShowIsLoaded;
          emit(
            NoteShowIsLoaded(data: current.data),
          );
        } else {
          emit(NoteInitial());
        }
      },
    );
    on<NoteRemoveTag>(
      (event, emit) {
        List<KeyValue> newTags = List<KeyValue>.from(tags);
        newTags.removeWhere((element) => element.name == event.tag.name);
        tags = newTags;
        if (state is NoteShowIsLoaded) {
          NoteShowIsLoaded current = state as NoteShowIsLoaded;
          emit(
            NoteShowIsLoaded(data: current.data),
          );
        } else {
          emit(NoteInitial());
        }
      },
    );
  }

  Future<void> _GetData(
    NoteGetData event,
    Emitter<NoteState> emit,
    NoteState state,
  ) async {
    try {
      int _page = 1;
      if (state is NoteIsLoaded && !event.refresh) {
        _page = state.page;
        state.IsloadingPage = true;
        emit(
          NoteIsLoaded(data: state.data, IsloadingPage: true),
        );
      } else {
        emit(NoteIsLoading());
      }

      Map<String, dynamic> result = await FetchData(data: Data.note).FINDALL(
        filters: [
          ["doc.type", "=", "visit"],
          ["doc._id", "=", event.docId]
        ],
        page: _page,
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }

      List<NoteModel> newData = NoteModel.fromJsonList(result['data']);

      List<NoteModel> currentData = [];
      if (state is NoteIsLoaded && !event.refresh) {
        currentData = state.data;
        currentData.addAll(newData);
      } else {
        currentData = newData;
      }

      emit(
        NoteIsLoaded(
          data: currentData,
          hasMore: result['hasMore'],
          total: result['total'],
          page: result['nextPage'],
          IsloadingPage: false,
        ),
      );
    } catch (e) {
      emit(
        NoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _ShowData(
    NoteShowData event,
    Emitter<NoteState> emit,
    NoteState state,
  ) async {
    try {
      if (event.isLoading) {
        emit(NoteIsLoading());
      }
      dynamic result = await FetchData(data: Data.note).FINDONE(id: event.id);
      if (result['status'] != 200) {
        throw result['msg'];
      }
      List<dynamic> tagsData = result['data']['tags'];
      tags = tagsData.map((item) {
        return KeyValue(name: item['name'], value: item['_id']);
      }).toList();

      emit(NoteShowIsLoaded(data: result['data']));
    } catch (e) {
      emit(
        NoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _UpdateData(
    NoteUpdateData event,
    Emitter<NoteState> emit,
    NoteState state,
  ) async {
    try {
      // emit(VisitNoteIsLoading());
      dynamic result = await FetchData(data: Data.note).UPDATEONE(
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
      add(NoteShowData(
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
        NoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _DeleteData(
    NoteDeleteData event,
    Emitter<NoteState> emit,
    NoteState state,
  ) async {
    try {
      emit(NoteIsLoading());

      dynamic result = await FetchData(data: Data.note).DELETEONE(event.id);
      if (result['status'] != 200) {
        throw result['msg'];
      }
      emit(NoteDeleteSuccess());
    } catch (e) {
      emit(
        NoteIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _InsertData(
    NoteAddData event,
    Emitter<NoteState> emit,
    NoteState state,
  ) async {
    try {
      emit(NoteIsLoading());
      dynamic result = await FetchData(data: Data.note).ADD(
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

      add(NoteShowData(
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
        NoteIsFailure(
          e.toString(),
        ),
      );
    }
  }
}
