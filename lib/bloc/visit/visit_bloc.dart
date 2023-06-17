import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  VisitBloc() : super(VisitInitial()) {
    on<VisitEvent>((event, emit) async {
      if (event is TabChanged) {
        print(event.tabIndex);
      } else if (event is GetData) {
        emit(IsLoading());
        try {
          List<dynamic> getData = await FetchData(data: Data.visit).FIND();

          List<Visitmodel> visitList = Visitmodel.fromJsonList(getData);
          // print(visitList);
          emit(IsLoaded(visitList));
        } catch (e) {
          emit(IsFailure(e.toString()));
        }
      }
    });
  }
}
