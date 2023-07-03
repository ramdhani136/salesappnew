import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/item_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/utils/local_data.dart';
import 'package:jwt_decode/jwt_decode.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  LocalData localData = LocalData();
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
      String? token = await localData.getToken();

      String erpUri = "";

      if (token != null) {
        Map<String, dynamic> decodedJwt = Jwt.parseJwt(token);
        Map<String, dynamic> user = await FetchData(data: Data.users).FINDONE(
          id: decodedJwt['_id'],
        );
        if (user['data']['ErpSite'] != null) {
          erpUri = "${user['data']['ErpSite']}";
        }
      }
      print(erpUri);
      emit(ItemShowIsLoaded(data: data, workflow: action, erpUrl: erpUri));
    } catch (e) {
      emit(ItemIsFailure(e.toString()));
    }
  }
}
