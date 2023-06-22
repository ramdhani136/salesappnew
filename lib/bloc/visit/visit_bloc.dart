// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  int _page = 1;
  String search = "";

  VisitBloc() : super(VisitInitial()) {
    on<GetData>(_GetAllData);
    on<ChangeSearch>((event, emit) async {
      search = event.search;
    });
    on<DeleteOne>(_DeleteOne);
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
        throw getData['msg'];
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
