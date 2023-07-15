// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/repositories/tags_repository.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  int page = 1;
  String search = "";
  TagsBloc() : super(TagsInitial()) {
    on<TagChangeSearch>((event, emit) async {
      search = event.search;
    });
    on<TagGetAll>(_GetAllData);
    on<TagInsert>(_InsertData);
  }

  Future<void> _GetAllData(
    TagGetAll event,
    Emitter<TagsState> emit,
  ) async {
    try {
      if (event.search != null) {
        search = event.search!;
      }
      if (state is TagsIsLoaded && !event.refresh) {
        TagsIsLoaded current = state as TagsIsLoaded;

        page = current.page;
        current.pageLoading = true;
        emit(
          TagsIsLoaded(
            data: current.data,
            pageLoading: true,
            hasMore: current.hasMore,
            page: current.page,
            total: current.total,
          ),
        );
      } else {
        if (event.refresh) {
          EasyLoading.show(status: 'loading...');
          emit(TagsIsLoading());
        }
      }

      final Map<String, dynamic> result = await RepositoryGetAllTags(
        filters: event.filters,
        limit: 10,
        page: event.refresh ? 1 : page,
        search: event.search,
      );

      List newData = result['data'];

      List currentData = [];

      if (state is TagsIsLoaded && !event.refresh) {
        TagsIsLoaded current = state as TagsIsLoaded;
        currentData = current.data;
        currentData.addAll(newData);
      } else {
        currentData = newData;
      }

      emit(
        TagsIsLoaded(
          data: currentData,
          hasMore: result['hasMore'],
          total: result['total'],
          page: result['nextPage'],
          pageLoading: false,
        ),
      );
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      emit(
        tagsIsFailure(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _InsertData(
    TagInsert event,
    Emitter<TagsState> emit,
  ) async {
    try {
      EasyLoading.show(status: 'loading...');
      emit(TagsIsLoading());
      dynamic result = await FetchData(data: Data.tag).ADD(event.data);
      if (result['status'] != 200) {
        throw result['msg'];
      }
      Get.back();
      add(TagGetAll(search: search));
    } catch (e) {
      EasyLoading.dismiss();
      Get.defaultDialog(
        title: 'Error',
        content: Text(e.toString()),
      );
    }
  }
}
