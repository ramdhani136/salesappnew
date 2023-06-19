import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  int nextPage = 0;
  bool hasMore = false;
  int total = 0;
  VisitBloc() : super(VisitInitial()) {
    on<VisitEvent>((event, emit) async {
      if (event is TabChanged) {
        print(event.tabIndex);
      } else if (event is GetData) {
        print('d');
        emit(IsLoading());
        try {
          Map<String, dynamic> getData =
              await FetchData(data: Data.visit).FIND();
          print(getData['nextPage']);
          print(getData['total']);
          print(getData['hasMore']);

          List<Visitmodel> visitList = Visitmodel.fromJsonList(getData['data']);
          emit(IsLoaded(visitList));
        } catch (e) {
          emit(IsFailure(e.toString()));
        }
      }
    });
  }
}
