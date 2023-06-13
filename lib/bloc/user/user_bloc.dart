import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/repositories/user_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepositiory repository;
  UserBloc(this.repository) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUsers) {
        try {
          emit(UserLoading());
          final users = await UserRepositiory().getUsers();

          emit(UserLoaded(users));
        } catch (e) {
          Fluttertoast.showToast(
            msg: "$e",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[900],
            textColor: Colors.white,
            fontSize: 15.0,
          );
          emit(UserFailure(e.toString()));
        }
      }
    });
  }
}
