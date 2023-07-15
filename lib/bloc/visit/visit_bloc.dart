// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, unnecessary_import, use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/models/task_visit_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/history_model.dart';
import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/screens/visit/visit_form.dart';
// import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/models/action_model.dart';
import 'package:salesappnew/utils/local_data.dart';
import 'package:signature/signature.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  int _page = 1;
  String search = "";
  // AuthBloc authBloc = AuthBloc(AuthRepository());
  Position? checkOutCordinates;
  String? checkOutAddress;
  int? tabActive;
  Uint8List? signature;
  KeyValue? naming;
  KeyValue? customer;
  KeyValue? group;
  List? namingList;

  VisitBloc() : super(VisitInitial()) {
    on<GetData>(_GetAllData);
    on<VisitSetForm>((event, emit) {
      if (event.naming != null) {
        naming = event.naming;
      }
      if (event.customer != null) {
        customer = event.customer;
      }
      if (event.group != null) {
        group = event.group;
      }
      emit(IsLoading());
      emit(VisitInitial());
    });
    on<VisitResetForm>((event, emit) {
      if (event.naming) {
        naming = null;
      }
      if (event.customer) {
        customer = null;
      }

      if (event.group) {
        group = null;
      }
      if (state is IsLoaded) {
        IsLoaded current = state as IsLoaded;
        emit(IsLoading());
        emit(
          IsLoaded(
            hasMore: current.hasMore,
            newData: current.data,
            pageLoading: current.pageLoading,
            total: current.total,
          ),
        );
      } else {
        emit(IsLoading());
        emit(VisitInitial());
      }
    });
    on<InsertVisit>(_PostData);
    on<ChangeSearch>((event, emit) async {
      search = event.search;
    });
    on<VisitUpdateData>(_UpdateData);
    on<VisitChangeImage>(_ChangeImage);
    on<DeleteOne>(_DeleteOne);
    on<ShowData>(_ShowData);
    on<ChangeWorkflow>(_ChangeWorkflow);
    on<SetCheckOut>(_SetCheckOut);
    on<UpdateSignature>(_exportSignature);
    on<ClearSignature>(
      (event, emit) {
        signature = null;
        add(ShowData(
          id: event.id,
          isLoading: false,
        ));
      },
    );
    on<VisitGetNaming>(_getNaming);
  }

  Future<void> _PostData(
    InsertVisit event,
    Emitter<VisitState> emit,
  ) async {
    try {
      EasyLoading.show(status: 'loading...');
      emit(IsLoadingPage());
      dynamic data = await FetchData(data: Data.visit).ADD(event.data);
      if ((data['status']) != 200) {
        throw data['msg'];
      }

      if (event.visitBloc != null) {
        event.visitBloc!.add(
          GetData(
            getRefresh: true,
            search: event.visitBloc!.search,
            status: event.visitBloc!.tabActive != null
                ? event.visitBloc!.tabActive!
                : 1,
          ),
        );

        Get.back();
        Get.back();
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => VisitForm(
              id: "${data['data']['_id']}",
              visitBloc: event.visitBloc!,
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

  Future<Uint8List?> _exportSignature(
      UpdateSignature event, Emitter<VisitState> emit) async {
    try {
      final exportController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white,
        points: event.controller.points,
      );

      final isSignature = await exportController.toPngBytes();
      exportController.dispose();

      signature = isSignature;
      add(ShowData(
        id: event.id,
        isLoading: false,
      ));
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<void> _ChangeImage(
    VisitChangeImage event,
    Emitter<VisitState> emit,
  ) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        var request = http.MultipartRequest(
          'PUT',
          Uri.parse("${Config().baseUri}visit/${event.id}"),
        );

        var stream = http.ByteStream(pickedFile.openRead())..cast();
        var length = await pickedFile.length();
        var multipartFile = http.MultipartFile(
          'img',
          stream,
          length,
          filename: basename(pickedFile.path),
        );
        request.files.add(multipartFile);

        request.headers['authorization'] =
            'Bearer ${await LocalData().getToken()}';
        http.Response response = await http.Response.fromStream(
          await request.send(),
        );

        if (response.statusCode != 200) {
          throw response.body;
        }

        add(ShowData(
          id: event.id,
        ));
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
    }
  }

  Future<void> _UpdateData(
    VisitUpdateData event,
    Emitter<VisitState> emit,
  ) async {
    try {
      emit(IsLoading());

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse("${Config().baseUri}visit/${event.id}"),
      );

      request.fields["contact"] = event.data['contact'];
      request.headers['authorization'] =
          'Bearer ${await LocalData().getToken()}';
      http.Response response = await http.Response.fromStream(
        await request.send(),
      );

      if (response.statusCode != 200) {
        throw response.body;
      }

      add(ShowData(id: event.id));
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
    }
  }

  Future<void> _DeleteOne(DeleteOne event, Emitter<VisitState> emit) async {
    try {
      dynamic data = await FetchData(data: Data.visit).DELETEONE(event.id);
      if ((data['status']) != 200) {
        throw data['msg'];
      }
      emit(DeleteSuccess());
    } catch (e) {
      emit(DeleteFailure(e.toString()));
    }
  }

  Future<void> _ChangeWorkflow(
      ChangeWorkflow event, Emitter<VisitState> emit) async {
    try {
      emit(IsLoading());
      dynamic data = await FetchData(data: Data.visit).UPDATEONE(
        event.id,
        {"nextState": event.nextStateId},
      );

      if (data['status'] != 200) {
        throw data['msg'];
      }

      add(ShowData(id: event.id));
    } catch (e) {
      emit(IsFailure(e.toString()));
      add(ShowData(id: event.id));
    }
  }

  Future<void> _SetCheckOut(SetCheckOut event, Emitter<VisitState> emit) async {
    try {
      // emit(IsLoading());
      EasyLoading.show(status: 'loading...');
      dynamic data = await FetchData(data: Data.visit).UPDATEONE(
        event.id,
        {
          "signature": base64.encode(signature!),
          "checkOutLat": checkOutCordinates!.latitude,
          "checkOutLng": checkOutCordinates!.longitude
        },
      );

      if (data['status'] != 200) {
        throw data['msg'];
      }
      EasyLoading.dismiss();

      add(ShowData(id: event.id, isLoading: false));
    } catch (e) {
      emit(IsFailure(e.toString()));
      add(ShowData(id: event.id, isLoading: false));
      EasyLoading.dismiss();
    }
  }

  Future<void> _ShowData(ShowData event, Emitter<VisitState> emit) async {
    try {
      if (event.isLoading) {
        emit(IsLoading());
      }
      Map<String, dynamic> data = await FetchData(data: Data.visit).FINDONE(
        id: event.id,
      );

      Visitmodel result = Visitmodel.fromJson(data['data']);

      List<ActionModel> action = ActionModel.fromJsonList(data['workflow']);
      List<HistoryModel> history = HistoryModel.fromJsonList(data['history']);

      List<TaskVisitModel> task =
          TaskVisitModel.fromJsonList(data['data']['taskNotes']);

      if ((data['status']) != 200) {
        throw data['msg'];
      }

      emit(IsShowLoaded(
        data: result,
        workflow: action,
        history: history,
        task: task,
      ));
    } catch (e) {
      emit(IsFailure(e.toString()));
    }
  }

  Future<void> _GetAllData(GetData event, Emitter<VisitState> emit) async {
    try {
      signature = null;
      checkOutAddress = null;
      checkOutCordinates = null;
      if (state is! IsLoaded || event.getRefresh) {
        emit(IsLoading());
      } else {
        IsLoaded current = state as IsLoaded;
        emit(
          IsLoaded(
            newData: current.data,
            hasMore: current.hasMore,
            total: current.total,
            pageLoading: true,
          ),
        );
      }

      Map<String, dynamic> getData = await FetchData(data: Data.visit).FINDALL(
          page: event.getRefresh ? 1 : _page,
          filters: [
            [
              "status",
              "=",
              "${event.status}",
            ]
          ],
          search: event.search);

      if (getData['status'] == 200) {
        _page = getData['nextPage'];
        List<Visitmodel> visitList = Visitmodel.fromJsonList(getData['data']);

        List<Visitmodel> currentData = [];
        if (state is IsLoaded && !event.getRefresh) {
          currentData = (state as IsLoaded).data;
          currentData.addAll(visitList);
        } else {
          currentData = visitList;
        }

        emit(
          IsLoaded(
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
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
        );

        emit(TokenExpired(getData['msg']));
      } else {
        _page = 1;
        List<Visitmodel> visitList = Visitmodel.fromJsonList([]);

        emit(
          IsLoaded(
            newData: visitList,
            hasMore: false,
            total: 0,
            pageLoading: false,
          ),
        );
        Fluttertoast.showToast(
          msg: getData['msg'].toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
        );
      }
    } catch (e) {
      emit(IsFailure(e.toString()));
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
    }
  }

  Future<void> _getNaming(
      VisitGetNaming event, Emitter<VisitState> emit) async {
    try {
      EasyLoading.show(status: 'loading...');
      Map<String, dynamic> result =
          await FetchData(data: Data.namingSeries).FINDALL(
        filters: [
          ["doc", "=", "visit"]
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
      emit(VisitInitial());
      EasyLoading.dismiss();
    } catch (e) {
      emit(IsFailure(e.toString()));
      EasyLoading.dismiss();
    }
  }
}
