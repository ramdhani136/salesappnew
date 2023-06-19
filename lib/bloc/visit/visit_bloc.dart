import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  int _page = 1;
  bool pageLoading = false;
  VisitBloc() : super(VisitInitial()) {
    on<VisitEvent>((event, emit) async {
      if (event is TabChanged) {
        print(event.tabIndex);
      } else if (event is GetData) {
        print("panggil");
        try {
          if (state is IsLoaded) {
            pageLoading = true;
          } else {
            emit(IsLoading());
          }

          Map<String, dynamic> getData =
              await FetchData(data: Data.visit, setPage: _page).FIND();
          _page = getData['nextPage'];

          List<Visitmodel> visitList = Visitmodel.fromJsonList(getData['data']);

          if (state is IsLoaded) {
            List<Visitmodel> currentData = (state as IsLoaded).data;

            visitList.addAll(currentData);
          }

          emit(IsLoaded(
              newData: visitList,
              hasMore: getData['hasMore'],
              total: getData['total']));
          pageLoading = false;
        } catch (e) {
          emit(IsFailure(e.toString()));
        }
      }
    });
  }
}
