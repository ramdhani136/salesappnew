import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:salesappnew/models/order_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<GetOrdershow>(_ShowData);
  }

  Future<void> _ShowData(
    GetOrdershow event,
    Emitter<OrderState> emit,
  ) async {
    try {
      emit(OrderIsLoading());
      Map<String, dynamic> result = await FetchData(data: Data.erp).FINDONE(
        id: event.id,
        params: "/Sales Order",
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }
      OrderModel data = OrderModel.fromJson(result['data']);
      List<dynamic> action = result['workflow'];

      emit(OrderShowIsLoaded(data: data, workflow: action));
    } catch (e) {
      emit(OrderIsFailure(e.toString()));
    }
  }
}
