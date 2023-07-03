import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/models/invoice_model.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(InvoiceInitial()) {
    on<InvoiceGetOverDue>(
      (event, emit) {
        return _GetOverDue(event, emit, state);
      },
    );
    on<GetInvoiceShow>(_ShowData);
  }

  Future<void> _ShowData(
    GetInvoiceShow event,
    Emitter<InvoiceState> emit,
  ) async {
    try {
      emit(InvoiceLoading());
      Map<String, dynamic> result = await FetchData(data: Data.erp).FINDONE(
        id: event.invoiceID,
        params: "/Sales Invoice",
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }
      InvoiceModel data = InvoiceModel.fromJson(result['data']);
      List<dynamic> action = result['workflow'];

      emit(InvoiceShowIsLoaded(data: data, workflow: action));
    } catch (e) {
      emit(InvoiceFailure(e.toString()));
    }
  }

  Future<void> _GetOverDue(InvoiceGetOverDue event, Emitter<InvoiceState> emit,
      InvoiceState state) async {
    try {
      int page = 1;

      if (event.customerId != "null") {
        if (state is InvoiceLoadedOverdue) {
          emit(InvoiceInfiniteLoading());
          page = state.page;
        } else {
          emit(InvoiceLoading());
          emit(InvoiceInfiniteLoading());
        }

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
          page: page,
        );

        if ((result['status']) != 200) {
          throw result['msg'];
        }

        emit(
          InvoiceLoadedOverdue(
            data: result['data'],
            hasMore: result['hasMore'],
            page: result['nextPage'],
          ),
        );
      }
    } catch (e) {
      if (state is InvoiceLoadedOverdue) {
        state.hasMore = false;
      }

      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );

      emit(InvoiceFailure(e.toString()));
    }
  }
}
