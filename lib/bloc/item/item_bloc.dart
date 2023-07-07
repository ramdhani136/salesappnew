import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/item_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/utils/local_data.dart';
import 'package:jwt_decode/jwt_decode.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  String search = "";
  int page = 1;
  int? tabActive;
  LocalData localData = LocalData();
  ItemBloc() : super(ItemInitial()) {
    on<GetItemShow>(_ShowData);
    on<ItemGetAll>(_GetAllData);
    on<ItemChangeSearch>((event, emit) async {
      search = event.search;
    });
  }

  Future<void> _GetAllData(ItemGetAll event, Emitter<ItemState> emit) async {
    try {
      int page = 1;
      if (state is! ItemIsLoaded || event.getRefresh) {
        emit(ItemIsLoading());
      } else {
        ItemIsLoaded current = state as ItemIsLoaded;
        emit(
          ItemIsLoaded(
              data: current.data,
              hasMore: current.hasMore,
              pageLoading: true,
              erpUri: current.erpUri),
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
        filters.add(["item_name", "like", "%${event.search}%"]);
      }

      Map<String, dynamic> getData = await FetchData(data: Data.erp).FINDALL(
        page: event.getRefresh ? 1 : page,
        params: "/Item",
        fields: [
          "name",
          "item_name",
          "image",
          "docstatus",
        ],
        filters: filters,
      );

      if (getData['status'] == 200) {
        page = getData['nextPage'];
        List response = getData['data'];

        List currentData = [];
        if (state is ItemIsLoaded && !event.getRefresh) {
          currentData = (state as ItemIsLoaded).data;
          currentData.addAll(response);
        } else {
          currentData = response;
        }

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

        emit(
          ItemIsLoaded(
            data: currentData,
            hasMore: getData['hasMore'],
            pageLoading: false,
            erpUri: erpUri,
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

        emit(ItemTokenExpired(getData['msg']));
      } else {
        List visitList = [];
        emit(
          ItemIsLoaded(
            data: visitList,
            hasMore: false,
            pageLoading: false,
            erpUri: "",
          ),
        );
        throw (getData['msg']);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
      page = 1;
      emit(ItemIsFailure(e.toString()));
    }
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

      emit(ItemShowIsLoaded(data: data, workflow: action, erpUrl: erpUri));
    } catch (e) {
      emit(ItemIsFailure(e.toString()));
    }
  }
}
