// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/repositories/memo_repository.dart';

part 'memo_event.dart';
part 'memo_state.dart';

class MemoBloc extends Bloc<MemoEvent, MemoState> {
  int page = 1;
  MemoBloc() : super(MemoInitial()) {
    on<MemoGetAllData>(GetAll);
  }

  Future<void> GetAll(MemoGetAllData event, Emitter<MemoState> emit) async {
    try {
      List<List<String>> isFilters = [];

      if (event.filters != null) {
        isFilters.addAll(event.filters!);
      }
      if (event.status != null) {
        isFilters.addAll([
          [
            "status",
            "=",
            "${event.status}",
          ]
        ]);
      }

      if (state is! MemoIsLoaded || event.getRefresh) {
        EasyLoading.show(status: 'loading...');
      } else {
        MemoIsLoaded current = state as MemoIsLoaded;
        current.copyWith(pageLoading: true);
        emit(current);
      }

      Map<String, dynamic> result = await RepositoryGetAllMemo(
          page: event.getRefresh ? 1 : page,
          filters: isFilters,
          search: event.search);

      page = result['nextPage'];
      List isData = result['data'];

      List currentData = [];
      if (state is MemoIsLoaded && !event.getRefresh) {
        currentData = (state as MemoIsLoaded).data;
        currentData.addAll(isData);
      } else {
        currentData = isData;
      }
      emit(
        MemoIsLoaded(
          data: currentData,
          hasMore: result['hasMore'],
          total: result['total'],
          pageLoading: false,
        ),
      );
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      emit(
        MemoIsFailure(
          error: e.toString(),
        ),
      );
    }
  }
}
