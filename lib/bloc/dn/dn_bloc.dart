import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/dn_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'dn_event.dart';
part 'dn_state.dart';

class DnBloc extends Bloc<DnEvent, DnState> {
  DnBloc() : super(DnInitial()) {
    on<GetDnShow>(_ShowData);
  }
  Future<void> _ShowData(
    GetDnShow event,
    Emitter<DnState> emit,
  ) async {
    try {
      emit(DnIsLoading());
      Map<String, dynamic> result = await FetchData(data: Data.erp).FINDONE(
        id: event.id,
        params: "/Delivery Note",
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }
      DnModel data = DnModel.fromJson(result['data']);
      List<dynamic> action = result['workflow'];

      emit(DnShowIsLoaded(data: data, workflow: action));
    } catch (e) {
      emit(DnIsFailure(e.toString()));
    }
  }
}
