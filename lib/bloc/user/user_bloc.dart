// ignore_for_file: unnecessary_import, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/material.dart';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/models/user_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/utils/local_data.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  XFile? img;

  String? id;

  UserBloc() : super(UserInitial()) {
    on<GetUserLogin>(
      (event, emit) async {
        try {
          emit(UserLoading());
          dynamic token = await LocalData().getToken();
          Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

          Map<String, dynamic> getUser =
              await FetchData(data: Data.users).FINDONE(
            id: decodedToken["_id"],
          );

          if (getUser['status'] != 200) {
            throw getUser['msg'];
          }

          UserModel user = UserModel.fromJson(getUser['data']);

          id = user.id;

          emit(UserLoginLoaded(data: user));
        } catch (e) {
          emit(UserFailure(e.toString()));
        }
      },
    );
    on<UserSetImage>(
      (event, emit) async {
        try {
          if (state is UserLoginLoaded) {
            final current = state as UserLoginLoaded;
            var image = await ImagePicker().pickImage(source: event.source);

            img = image;
            emit(UserLoginLoaded(data: current.data));
          }
        } catch (e) {
          Get.defaultDialog(
            title: e.toString(),
            content: Text(e.toString()),
            contentPadding: const EdgeInsets.all(16),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK'),
              ),
            ],
          );
          rethrow;
        }
      },
    );

    on<UserSetUpdate>(
      (event, emit) async {
        if (state is UserLoginLoaded) {
          emit(UserLoading());
          try {
            var request = http.MultipartRequest(
              'PUT',
              Uri.parse("${Config().baseUri}users/$id"),
            );

            if (img != null) {
              var stream = http.ByteStream(img!.openRead())..cast();
              var length = await img!.length();
              var multipartFile = http.MultipartFile(
                'img',
                stream,
                length,
                filename: basename(img!.path),
              );

              request.files.add(multipartFile);
            }

            if (event.data['name'] != null) {
              request.fields['name'] = event.data['name'];
            }
            if (event.data['username'] != null) {
              request.fields['username'] = event.data['username'];
            }
            if (event.data['email'] != null) {
              request.fields['email'] = event.data['email']!;
            }
            if (event.data['phone'] != null) {
              request.fields['phone'] = event.data['phone'];
            }
            if (event.data['ErpSite'] != null) {
              request.fields['ErpSite'] = event.data['ErpSite']!;
            }
            if (event.data['ErpToken'] != null) {
              request.fields['ErpToken'] = event.data['ErpToken'];
            }
            if (event.data['password'] != null) {
              request.fields['password'] = event.data['password']!;
            }

            request.headers['authorization'] =
                'Bearer ${await LocalData().getToken()}';
            http.Response response = await http.Response.fromStream(
              await request.send(),
            );

            if (response.statusCode != 200) {
              throw response.body;
            }

            add(GetUserLogin());
          } catch (e) {
            Get.defaultDialog(
              title: 'Error',
              content: Text(e.toString()),
              contentPadding: const EdgeInsets.all(16),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
