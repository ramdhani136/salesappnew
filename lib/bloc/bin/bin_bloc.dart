// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/bin_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'bin_event.dart';
part 'bin_state.dart';

class BinBloc extends Bloc<BinEvent, BinState> {
  BinBloc() : super(BinInitial()) {
    on<GetBinByItem>(_BinByItem);
  }

  Future<void> _BinByItem(
    GetBinByItem event,
    Emitter<BinState> emit,
  ) async {
    try {
      emit(BinIsLoading());
      Map<String, dynamic> result =
          await FetchData(data: Data.erp).FINDALL(params: "/Bin", fields: [
        "name",
        "item_code",
        "item_name",
        "reserved_qty",
        "actual_qty",
        "ordered_qty",
        "indented_qty",
        "planned_qty",
        "projected_qty"
      ], filters: [
        ["item_code", "=", event.itemId],
        ["warehouse", "=", "Head Quarter - ETM-BGR"]
      ]);

      if (result['status'] != 200) {
        throw result['msg'];
      }

      List<BinModel> data = BinModel.fromJsonList(result['data']);

      emit(BinByItemIsLoaded(
        data: data,
      ));
    } catch (e) {
      emit(BinIsFailure(e.toString()));
    }
  }
}
