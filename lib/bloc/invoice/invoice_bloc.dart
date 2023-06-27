import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(InvoiceInitial()) {
    on<InvoiceGetOverDue>(_GetOverDue);
  }
}

Future<void> _GetOverDue(
    InvoiceGetOverDue event, Emitter<InvoiceState> emit) async {
  try {
    if (event.customerId != "null") {
      emit(InvoiceLoading());

      Map<String, dynamic> result = await FetchData(data: Data.erp).FINDALL(
        params: "/Sales Invoice",
        filters: [
          [
            "customer",
            "=",
            event.customerId,
          ],
          [
            "status",
            "=",
            "Overdue",
          ]
        ],
        fields: [
          "name",
          "customer",
          "posting_date",
          "due_date",
          "grand_total",
          "outstanding_amount",
          "payment_terms_template"
        ],
      );

      if ((result['status']) != 200) {
        throw result['msg'];
      }

      emit(InvoiceLoadedOverdue(
        data: result['data'],
      ));
    }
  } catch (e) {
    emit(InvoiceFailure(e.toString()));
  }
}
