import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/repositories/user_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isPasswordVisible = false;
  final UserRepositiory repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is OnLogin) {
          emit(AuthLoading());
          try {
            final isLogin =
                await repository.loginUser(event.username, event.password);
            emit(AuthSuccess(isLogin));
          } catch (error) {
            Fluttertoast.showToast(
              msg: "Terjadi kesalahan: $error ",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey[900],
              textColor: Colors.white,
              fontSize: 16.0,
            );
            emit(AuthFailure(error.toString()));
          }
        } else if (event is TogglePasswordVisibility) {
          isPasswordVisible = !isPasswordVisible;
          emit(AuthInitial());
        }
      },
    );
  }
}
