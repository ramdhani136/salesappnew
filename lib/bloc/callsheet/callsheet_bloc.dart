// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesappnew/models/action_model.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/models/task_callsheet_model.dart';
import 'package:salesappnew/models/history_model.dart';
import 'package:salesappnew/models/callsheet_model.dart';
import 'package:salesappnew/screens/callsheet/callsheet_form_screen.dart';
import 'package:salesappnew/utils/fetch_data.dart';

part 'callsheet_event.dart';
part 'callsheet_state.dart';

class CallsheetBloc extends Bloc<CallsheetEvent, CallsheetState> {
  int page = 1;
  String search = "";
  int? tabActive;
  KeyValue? naming;
  KeyValue? customer;
  KeyValue? group;
  KeyValue? branch;
  KeyValue? contact;
  String type = "in";
  List? namingList;
  CallsheetBloc() : super(CallsheetInitial()) {
    on<CallsheetSetForm>((event, emit) {
      if (event.naming != null) {
        naming = event.naming;
      }
      if (event.customer != null) {
        customer = event.customer;
      }
      if (event.group != null) {
        group = event.group;
      }
      if (event.type != null) {
        type = event.type!;
      }
      if (event.branch != null) {
        branch = event.branch!;
      }
      if (event.contact != null) {
        contact = event.contact!;
      }
      emit(CallsheetIsLoading());
      emit(CallsheetInitial());
    });
    on<CallsheetUpdateData>(_UpdateData);
    on<CallsheetResetForm>((event, emit) {
      if (event.naming) {
        naming = null;
      }
      if (event.customer) {
        customer = null;
      }
      if (event.branch) {
        branch = null;
      }
      if (event.contact) {
        contact = null;
      }

      if (event.group) {
        group = null;
      }
      if (state is CallsheetIsLoaded) {
        CallsheetIsLoaded current = state as CallsheetIsLoaded;
        emit(CallsheetIsLoading());
        emit(
          CallsheetIsLoaded(
            hasMore: current.hasMore,
            newData: current.data,
            pageLoading: current.pageLoading,
            total: current.total,
          ),
        );
      } else {
        emit(CallsheetIsLoading());
        emit(CallsheetInitial());
      }
    });
    on<CallsheetGetAllData>(_GetAllData);
    on<CallsheetDeleteOne>(_DeleteOne);
    on<CallsheetShowData>(_ShowData);
    on<CallsheetChangeWorkflow>(_ChangeWorkflow);
    on<CallsheetInsert>(_PostData);
    on<CallsheetChangeSearch>((event, emit) async {
      search = event.search;
    });
    on<CallsheetGetNaming>(_getNaming);
  }

  Future<void> _UpdateData(
    CallsheetUpdateData event,
    Emitter<CallsheetState> emit,
  ) async {
    try {
      EasyLoading.show(status: 'loading...');

      Map response =
          await FetchData(data: Data.callsheet).UPDATEONE(event.id, event.data);

      if (response['status'] != 200) {
        throw response['msg'];
      }

      EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: "Saved",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );

      add(
        CallsheetShowData(
          id: event.id,
          isLoading: false,
        ),
      );
    } catch (e) {
      EasyLoading.dismiss();
      emit(
        CallsheetIsFailure(
          e.toString(),
        ),
      );
      add(CallsheetShowData(id: event.id));
      // Fluttertoast.showToast(
      //   msg: e.toString(),
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.grey[800],
      //   textColor: Colors.white,
      // );
    }
  }

  Future<void> _PostData(
    CallsheetInsert event,
    Emitter<CallsheetState> emit,
  ) async {
    try {
      EasyLoading.show(status: 'loading...');
      emit(CallsheetIsLoading());
      dynamic data = await FetchData(data: Data.callsheet).ADD(event.data);
      if ((data['status']) != 200) {
        throw data['msg'];
      }

      if (event.bloc != null) {
        event.bloc!.add(
          CallsheetGetAllData(
            getRefresh: true,
            search: event.bloc!.search,
            status: event.bloc!.tabActive != null ? event.bloc!.tabActive! : 1,
          ),
        );

        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => CallsheetForm(
              id: "${data['data']['_id']}",
              bloc: event.bloc!,
            ),
          ),
        );
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
    }
  }

  Future<void> _ChangeWorkflow(
      CallsheetChangeWorkflow event, Emitter<CallsheetState> emit) async {
    try {
      emit(CallsheetIsLoading());
      dynamic data = await FetchData(data: Data.callsheet).UPDATEONE(
        event.id,
        {"nextState": event.nextStateId},
      );

      if (data['status'] != 200) {
        throw data['msg'];
      }

      add(CallsheetShowData(id: event.id));
    } catch (e) {
      emit(CallsheetIsFailure(e.toString()));
      add(CallsheetShowData(id: event.id));
    }
  }

  Future<void> _ShowData(
    CallsheetShowData event,
    Emitter<CallsheetState> emit,
  ) async {
    try {
      if (event.isLoading) {
        emit(CallsheetIsLoading());
      }
      Map<String, dynamic> data = await FetchData(data: Data.callsheet).FINDONE(
        id: event.id,
      );

      CallsheetModel result = CallsheetModel.fromJson(data['data']);

      List<ActionModel> action = ActionModel.fromJsonList(data['workflow']);
      List<HistoryModel> history = HistoryModel.fromJsonList(data['history']);

      List<TaskCallsheetModel> task;
      if (data['data']['taskNotes'] != null) {
        task = TaskCallsheetModel.fromJsonList(data['data']['taskNotes']);
      } else {
        task = [];
      }

      if ((data['status']) != 200) {
        throw data['msg'];
      }

      branch = KeyValue(name: result.branch!.name!, value: result.branch!.id);
      group = KeyValue(
          name: result.customerGroup!.name!, value: result.customerGroup!.id);
      customer =
          KeyValue(name: result.customer!.name!, value: result.customer!.id);
      if (result.contact != null) {
        contact =
            KeyValue(name: result.contact!.name!, value: result.contact!.id);
      }
      emit(CallsheetIsShowLoaded(
        data: result,
        workflow: action,
        history: history,
        task: task,
      ));
    } catch (e) {
      emit(CallsheetIsFailure(e.toString()));
    }
  }

  Future<void> _DeleteOne(
      CallsheetDeleteOne event, Emitter<CallsheetState> emit) async {
    try {
      dynamic data = await FetchData(data: Data.callsheet).DELETEONE(event.id);
      if ((data['status']) != 200) {
        throw data['msg'];
      }
      emit(CallsheetDeleteSuccess());
    } catch (e) {
      emit(CallsheetDeleteFailure(e.toString()));
    }
  }

  Future<void> _GetAllData(
    CallsheetGetAllData event,
    Emitter<CallsheetState> emit,
  ) async {
    try {
      if (state is! CallsheetIsLoaded || event.getRefresh) {
        emit(CallsheetIsLoading());
      } else {
        CallsheetIsLoaded current = state as CallsheetIsLoaded;
        emit(
          CallsheetIsLoaded(
            newData: current.data,
            hasMore: current.hasMore,
            total: current.total,
            pageLoading: true,
          ),
        );
      }

      Map<String, dynamic> getData =
          await FetchData(data: Data.callsheet).FINDALL(
              page: event.getRefresh ? 1 : page,
              filters: [
                [
                  "status",
                  "=",
                  "${event.status}",
                ]
              ],
              search: event.search);

      if (getData['status'] == 200) {
        page = getData['nextPage'];
        List<CallsheetModel> response =
            CallsheetModel.fromJsonList(getData['data']);

        List<CallsheetModel> currentData = [];
        if (state is CallsheetIsLoaded && !event.getRefresh) {
          currentData = (state as CallsheetIsLoaded).data;
          currentData.addAll(response);
        } else {
          currentData = response;
        }

        emit(
          CallsheetIsLoaded(
            newData: currentData,
            hasMore: getData['hasMore'],
            total: getData['total'],
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

        emit(CallsheetTokenExpired(getData['msg']));
      } else {
        page = 1;
        List<CallsheetModel> data = CallsheetModel.fromJsonList([]);

        emit(
          CallsheetIsLoaded(
            newData: data,
            hasMore: false,
            total: 0,
            pageLoading: false,
          ),
        );
      }
    } catch (e) {
      emit(CallsheetIsFailure(e.toString()));
    }
  }

  Future<void> _getNaming(
      CallsheetGetNaming event, Emitter<CallsheetState> emit) async {
    try {
      EasyLoading.show(status: 'loading...');
      Map<String, dynamic> result =
          await FetchData(data: Data.namingSeries).FINDALL(
        filters: [
          ["doc", "=", "callsheet"]
        ],
        fields: ["_id", "name"],
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }

      namingList = result['data'].map((item) {
        return {
          "value": item["_id"],
          "title": item["name"],
        };
      }).toList();

      if (result['data'].length == 1) {
        naming = KeyValue(
          name: result['data'][0]['name'],
          value: result['data'][0]['_id'],
        );
      }
      emit(CallsheetInitial());
      EasyLoading.dismiss();
    } catch (e) {
      emit(CallsheetIsFailure(e.toString()));
      EasyLoading.dismiss();
    }
  }
}
