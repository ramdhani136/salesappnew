import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/customer_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial()) {
    on<ShowCustomer>(_ShowCustomer);
    on<GetAllCustomer>(_GetAllData);
  }

  Future<void> _GetAllData(
    GetAllCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      int page = 1;
      if (state is CustomerIsLoaded && !event.refresh) {
        CustomerIsLoaded current = state as CustomerIsLoaded;
        page = current.page;
        current.IsloadingPage = true;
        emit(
          CustomerIsLoaded(data: current.data, IsloadingPage: true),
        );
      } else {
        emit(CustomerIsLoading());
      }

      late Map<String, dynamic> result;

      if (event.nearby != null) {
        result = await FetchData(data: Data.customer).FINDALL(
          page: page,
          nearby: "&nearby=[${event.nearby!.lat},${event.nearby!.lng},0]",
        );
      } else {
        result = await FetchData(data: Data.customer).FINDALL(
          page: page,
        );
      }

      if (result['status'] != 200) {
        throw result['msg'];
      }

      List newData = result['data'];

      List currentData = [];

      if (state is CustomerIsLoaded && !event.refresh) {
        CustomerIsLoaded current = state as CustomerIsLoaded;
        currentData = current.data;
        currentData.addAll(newData);
      } else {
        currentData = newData;
      }

      emit(
        CustomerIsLoaded(
          data: currentData,
          hasMore: result['hasMore'],
          total: result['total'],
          page: result['nextPage'],
          IsloadingPage: false,
        ),
      );
    } catch (e) {
      emit(
        CustomerIsFailure(
          e.toString(),
        ),
      );
    }
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
