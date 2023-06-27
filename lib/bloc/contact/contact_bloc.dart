import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<GetListInput>(_GetListInput);
  }
  Future<void> _GetListInput(
      GetListInput event, Emitter<ContactState> emit) async {
    try {
      if (event.isLoading) {
        emit(ContactIsLoading());
      }
      Map<String, dynamic> result = await FetchData(data: Data.contact).FIND(
        page: 1,
        filters: [
          ["customer", "=", event.customerId],
        ],
        fields: ["name", "phone"],
      );

      List<dynamic> setData = result['data'].map((item) {
        return {
          'title': item["name"],
          'subTitle': item["phone"] ?? "",
          'value': item["_id"],
        };
      }).toList();

      if (result['status'] != 200) {
        throw result;
      }
      emit(ContactInput(data: setData));
    } catch (e) {
      emit(ContactIsFailure(e.toString()));
    }
  }
}
