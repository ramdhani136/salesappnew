import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  int _page = 1;

  VisitBloc() : super(VisitInitial()) {
    on<VisitEvent>((event, emit) async {
      if (event is GetData) {
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

          Map<String, dynamic> getData = await FetchData(
            data: Data.visit,
            setPage: event.getRefresh ? 1 : _page,
            filters: [
              [
                "status",
                "=",
                "${event.status}",
              ]
            ],
          ).FIND();
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
        } catch (e) {
          emit(IsFailure(e.toString()));
        }
      }
    });
  }
}
