// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/models/invoice_model.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  String search = "";
  int page = 1;
  int? tabActive;
  InvoiceBloc() : super(InvoiceInitial()) {
    on<InvoiceGetOverDue>(
      (event, emit) {
        return _GetOverDue(event, emit, state);
      },
    );
    on<GetInvoiceShow>(_ShowData);
    on<InvoiceGetAll>(_GetAllData);
    on<InvoiceChangeSearch>((event, emit) async {
      search = event.search;
    });
  }

  Future<void> _GetAllData(
      InvoiceGetAll event, Emitter<InvoiceState> emit) async {
    try {
      int page = 1;
      if (state is! InvoiceIsLoaded || event.getRefresh) {
        emit(InvoiceLoading());
      } else {
        InvoiceIsLoaded current = state as InvoiceIsLoaded;
        emit(
          InvoiceIsLoaded(
            data: current.data,
            hasMore: current.hasMore,
            pageLoading: true,
          ),
        );
      }

      List<List<String>> filters = [
        [
          "docstatus",
          "=",
          "${event.status}",
        ],
      ];

      if (event.search != "" && event.search != null) {
        filters.add(["name", "like", "${event.search}"]);
      }

      Map<String, dynamic> getData = await FetchData(data: Data.erp).FINDALL(
        page: event.getRefresh ? 1 : page,
        params: "/Sales Invoice",
        fields: [
          "customer",
          "name",
          "modified",
          "owner",
          "customer_group",
          "status",
          "docstatus",
          "grand_total",
          "outstanding_amount"
        ],
        filters: filters,
      );

      if (getData['status'] == 200) {
        page = getData['nextPage'];
        List response = getData['data'];

        List currentData = [];
        if (state is InvoiceIsLoaded && !event.getRefresh) {
          currentData = (state as InvoiceIsLoaded).data;
          currentData.addAll(response);
        } else {
          currentData = response;
        }

        emit(
          InvoiceIsLoaded(
            data: currentData,
            hasMore: getData['hasMore'],
            pageLoading: false,
          ),
        );
      } else if (getData['status'] == 403) {
        Fluttertoast.showToast(
          msg: getData['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
        );

        emit(InvoiceTokenExpired(getData['msg']));
      } else {
        List visitList = [];
        emit(
          InvoiceIsLoaded(
            data: visitList,
            hasMore: false,
            pageLoading: false,
          ),
        );
        throw (getData['msg']);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
      page = 1;
      // emit(InvoiceFailure(e.toString()));
    }
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
      if (event.customerId != "null") {
        if (state is! InvoiceLoadedOverdue || event.getRefresh) {
          EasyLoading.show(status: 'loading...');
        }

        if (state is InvoiceLoadedOverdue && !event.getRefresh) {
          final updatedState = state.copyWith(pageLoading: true);
          emit(updatedState);
          page = state.page;
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
          limit: 10,
          fields: [
            "name",
            "customer",
            "posting_date",
            "due_date",
            "grand_total",
            "outstanding_amount",
            "payment_terms_template"
          ],
          page: event.getRefresh ? 1 : page,
        );

        if ((result['status']) != 200) {
          throw result['msg'];
        }

        List genData = result['data'].map((item) {
          var currencyFormat = NumberFormat.currency(
            locale: 'en_US',
            symbol: '',
          );

          String outstandingAmount =
              currencyFormat.format(item['outstanding_amount']);
          return {
            "_id": item['name'],
            "from": "Sales Invoice",
            "name": item['name'],
            "title": "Tagihan konsumen",
            "notes":
                "Penagihan konsumen  ${item['customer']} Invoice no : ${item['name']} dengan total tagihan Rp.$outstandingAmount - jatuh tempo pada ${item['due_date']}"
          };
        }).toList();

        List currentData = [];

        if (state is InvoiceLoadedOverdue && !event.getRefresh) {
          currentData = state.data;
          currentData.addAll(genData);
        } else {
          currentData = genData;
        }

        if (currentData.isEmpty) {
          throw "No data";
        }
        EasyLoading.dismiss();
        emit(
          InvoiceLoadedOverdue(
            data: currentData,
            hasMore: result['hasMore'],
            page: result['nextPage'],
          ),
        );
      } else {
        throw "This customer not sync with erp system";
      }
    } catch (e) {
      print(e);
      if (state is InvoiceLoadedOverdue) {
        final updatedState = state.copyWith(pageLoading: false, hasMore: false);
        emit(updatedState);
      }
      if (event.getRefresh) {
        emit(
          InvoiceFailure(
            e.toString(),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "No more",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
        );
      }
      EasyLoading.dismiss();
    }
  }
}
