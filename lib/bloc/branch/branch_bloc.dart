// ignore_for_file: non_constant_identifier_names

import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesappnew/repositories/branch_repository.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<BranchGetAll>(_GetAll);
  }

  Future<void> _GetAll(BranchGetAll event, Emitter<BranchState> emit) async {
    try {
      List result = await BranchRepositoryGetAll();
      emit(
        BranchIsLoaded(data: result),
      );
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
}
