// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/visitnotes_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'visitnote_event.dart';
part 'visitnote_state.dart';

class VisitnoteBloc extends Bloc<VisitnoteEvent, VisitnoteState> {
  VisitnoteBloc() : super(VisitnoteInitial()) {
    on<GetVisitNote>(
      (event, emit) => _GetData(event, emit, state),
    );
  }
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
    } else {
      emit(VisitNoteIsLoading());
    }

    Map<String, dynamic> result = await FetchData(data: Data.visitnote).FINDALL(
      page: _page,
    );

    if (result['status'] != 200) {
      throw result['msg'];
    }

    List<VisitNoteModel> newData = VisitNoteModel.fromJsonList(result['data']);
    List<VisitNoteModel> currentData = [];
    if (state is VisitNoteIsLoaded && !event.refresh) {
      currentData = (state as VisitNoteIsLoaded).data;
      currentData.addAll(newData);
    } else {
      currentData = newData;
    }

    emit(
      VisitNoteIsLoaded(
        data: currentData,
        hasMore: result['hasMore'],
        total: result['total'],
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
