import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/item_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial()) {
    on<GetItemShow>(_ShowData);
  }

  Future<void> _ShowData(
    GetItemShow event,
    Emitter<ItemState> emit,
  ) async {
    try {
      emit(ItemIsLoading());
      Map<String, dynamic> result = await FetchData(data: Data.erp).FINDONE(
        id: event.id,
        params: "/Item",
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }
      ItemModel data = ItemModel.fromJson(result['data']);
      List<dynamic> action = result['workflow'];

      emit(ItemShowIsLoaded(data: data, workflow: action));
    } catch (e) {
      emit(ItemIsFailure(e.toString()));
    }
  }
}
