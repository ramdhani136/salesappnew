// ignore_for_file: unused_local_variable

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/models/customer_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:path/path.dart';
import 'package:salesappnew/utils/local_data.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  int page = 1;
  String search = "";
  CustomerBloc() : super(CustomerInitial()) {
    on<ShowCustomer>(_ShowCustomer);
    on<GetAllCustomer>(_GetAllData);
    on<UpdateCustomer>(_UpdateData);
    on<ChangeImageCustomer>(_ChangeImage);
    on<CustomerChangeSearch>((event, emit) async {
      search = event.search;
    });
  }

  Future<void> _GetAllData(
    GetAllCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      if (state is CustomerIsLoaded && !event.refresh) {
        CustomerIsLoaded current = state as CustomerIsLoaded;
        page = current.page;
        current.IsloadingPage = true;
        emit(
          CustomerIsLoaded(data: current.data, IsloadingPage: true),
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
        );
      } else {
        result = await FetchData(data: Data.customer).FINDALL(
          page: event.refresh ? 1 : page,
          filters: event.filters,
          search: event.search,
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
