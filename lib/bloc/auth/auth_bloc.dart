// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'package:bloc/bloc.dart';
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
        if (event is OnLogin) {
          emit(AuthLoading());
          try {
            await repository.loginUser(event.username, event.password);
            emit(AuthSuccess());
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
            emit(AuthFailure(error.toString()));
          }
        } else if (event is TogglePasswordVisibility) {
          isPasswordVisible = !isPasswordVisible;
          emit(AuthInitial());
        } else if (event is OnLogout) {
          await repository.logout();
          emit(AuthUnauthenticated());
          try {} catch (e) {
            emit(AuthFailure(e.toString()));
          }
        }
      },
    );
  }
}
