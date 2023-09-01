// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fielddatascroll_event.dart';
part 'fielddatascroll_state.dart';

class FielddatascrollBloc
    extends Bloc<FielddatascrollEvent, FielddatascrollState> {
  FielddatascrollBloc() : super(FielddatascrollInitial()) {
    on<FielddatascrollEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
