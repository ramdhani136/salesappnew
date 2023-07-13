// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesappnew/models/order_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  String search = "";
  int page = 1;
  int? tabActive;
  OrderBloc() : super(OrderInitial()) {
    on<GetOrdershow>(_ShowData);
    on<OrderGetAll>(_GetAllData);
    on<OrderChangeSearch>((event, emit) async {
      search = event.search;
    });
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

  Future<void> _GetAllData(OrderGetAll event, Emitter<OrderState> emit) async {
    try {
      int page = 1;
      if (state is! OrderIsLoaded || event.getRefresh) {
        emit(OrderIsLoading());
      } else {
        OrderIsLoaded current = state as OrderIsLoaded;
        emit(
          OrderIsLoaded(
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
        params: "/Sales Order",
        fields: [
          "customer",
          "name",
          "modified",
          "owner",
          "customer_group",
          "workflow_state",
          "docstatus",
          "grand_total",
          "per_delivered"
        ],
        filters: filters,
      );

      if (getData['status'] == 200) {
        page = getData['nextPage'];
        List response = getData['data'];

        List currentData = [];
        if (state is OrderIsLoaded && !event.getRefresh) {
          currentData = (state as OrderIsLoaded).data;
          currentData.addAll(response);
        } else {
          currentData = response;
        }

        emit(
          OrderIsLoaded(
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

        emit(OrderTokenExpired(getData['msg']));
      } else {
        List visitList = [];
        emit(
          OrderIsLoaded(
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
    }
  }
}
