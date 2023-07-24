// ignore_for_file: unnecessary_import, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/material.dart';
import 'package:salesappnew/models/user_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/utils/local_data.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  XFile? img;
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

          emit(UserLoginLoaded(data: user));
        } catch (e) {
          emit(UserFailure(e.toString()));
        }
      },
    );
    on<UserSetImage>((event, emit) async {
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
    });
  }
}
