import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/customer_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial()) {
    on<ShowCustomer>(_ShowCustomer);
  }

  Future<void> _ShowCustomer(
    ShowCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      emit(CustomerIsLoading());
      final Map<String, dynamic> response =
          await FetchData(data: Data.customer).FINDONE(id: event.customerId);

      if (response['status'] != 200) {
        throw response['msg'];
      }

      CustomerModel data = CustomerModel.fromJson(
        response['data'],
      );
      emit(CustomerShowLoaded(data: data));
    } catch (e) {
      emit(
        CustomerIsFailure(
          e.toString(),
        ),
      );
    }
  }
}
