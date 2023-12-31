// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isPasswordVisible = false;

  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is AppStarted) {
          emit(AuthLoading());
          final isAuthenticated = await repository.isAuthenticated();

          if (isAuthenticated) {
            emit(
              AuthAuthenticated(),
            );
          } else {
            emit(
              AuthUnauthenticated(),
            );
          }
        } else if (event is OnLogin) {
          // emit(AuthLoading());
          EasyLoading.show(status: 'loading...');
          try {
            await repository.loginUser(event.username, event.password);
            emit(AuthAuthenticated());
            EasyLoading.dismiss();
          } catch (error) {
            Fluttertoast.showToast(
              msg: "$error",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey[900],
              textColor: Colors.white,
              fontSize: 15.0,
            );
            EasyLoading.dismiss();
            // emit(AuthFailure(error.toString()));
          }
        } else if (event is TogglePasswordVisibility) {
          isPasswordVisible = !isPasswordVisible;
          emit(AuthInitial());
        } else if (event is OnLogout) {
          try {
            // emit(AuthLoading());
            await repository.logout();
            emit(AuthUnauthenticated());
            Get.offAllNamed('/login');
          } catch (e) {
            emit(AuthFailure(e.toString()));
          }
        }
      },
    );
  }
}
