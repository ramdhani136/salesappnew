// ignore_for_file: unused_local_variable, depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/models/customer_model.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:path/path.dart';
import 'package:salesappnew/utils/local_data.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  KeyValue? branch;
  KeyValue? group;
  KeyValue? name;
  int page = 1;
  String search = "";

  CustomerBloc() : super(CustomerInitial()) {
    on<ShowCustomer>(_ShowCustomer);
    on<CustomerInsert>(_InsertData);
    on<GetAllCustomer>(_GetAllData);
    on<UpdateCustomer>(_UpdateData);
    on<ChangeImageCustomer>(_ChangeImage);
    on<CustomerChangeSearch>((event, emit) async {
      search = event.search;
    });
    on<CustomerSetForm>((event, emit) {
      if (event.name != null) {
        name = event.name;
      }
      if (event.group != null) {
        group = event.group;
      }
      if (event.branch != null) {
        branch = event.branch;
      }
      emit(CustomerIsLoading());
      emit(CustomerInitial());
    });
    on<CustomerResetForm>((event, emit) {
      if (event.branch) {
        branch = null;
      }
      if (event.name) {
        name = null;
      }

      if (event.group) {
        group = null;
      }
      if (state is CustomerIsLoaded) {
        IsLoaded current = state as IsLoaded;
        emit(CustomerIsLoading());
        emit(
          CustomerIsLoaded(
            hasMore: current.hasMore,
            data: current.data,
            total: current.total,
          ),
        );
      } else {
        emit(CustomerIsLoading());
        emit(CustomerInitial());
      }
    });
  }

  Future<void> _InsertData(
    CustomerInsert event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      EasyLoading.show(status: 'loading...');
      Map<String, dynamic> result =
          await FetchData(data: Data.customer).ADD(event.data);

      if (result['status'] != 200) {
        throw result['msg'];
      }

      Get.back();

      EasyLoading.dismiss();
    } catch (e) {
      Get.defaultDialog(
        // title: "Ups, someting wrong",

        content: Text(
          e.toString(),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
      );
      EasyLoading.dismiss();
      emit(CustomerIsFailure(e.toString()));
    }
  }

  Future<void> _GetAllData(
    GetAllCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      if (event.search != null) {
        search = event.search!;
      }
      if (state is CustomerIsLoaded && !event.refresh) {
        CustomerIsLoaded current = state as CustomerIsLoaded;

        page = current.page;
        current.IsloadingPage = true;
        emit(
          CustomerIsLoaded(
            data: current.data,
            IsloadingPage: true,
            hasMore: current.hasMore,
            page: current.page,
            total: current.total,
          ),
        );
      } else {
        if (event.refresh) {
          EasyLoading.show(status: 'loading...');
          emit(CustomerIsLoading());
        }
      }

      late Map<String, dynamic> result;

      if (event.nearby != null) {
        result = await FetchData(data: Data.customer).FINDALL(
            page: event.refresh ? 1 : page,
            nearby: "&nearby=[${event.nearby!.lat},${event.nearby!.lng},0]",
            filters: event.filters,
            search: event.search,
            limit: 10);
      } else {
        result = await FetchData(data: Data.customer).FINDALL(
          page: event.refresh ? 1 : page,
          filters: event.filters,
          search: event.search,
          limit: 10,
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
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
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

  Future<void> _UpdateData(
    UpdateCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      emit(CustomerIsLoading());
      final Map<String, dynamic> response =
          await FetchData(data: Data.customer).UPDATEONE(event.id, event.data);

      if (response['status'] != 200) {
        throw response['msg'];
      }
      add(ShowCustomer(event.id));
    } catch (e) {
      emit(
        CustomerIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _ChangeImage(
    ChangeImageCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        var stream = http.ByteStream(pickedFile.openRead())..cast();
        var request = http.MultipartRequest(
          'PUT',
          Uri.parse("${Config().baseUri}customer/${event.id}"),
        );

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
        add(ShowCustomer(event.id));
      }
    } catch (e) {
      rethrow;
    }
  }
}
