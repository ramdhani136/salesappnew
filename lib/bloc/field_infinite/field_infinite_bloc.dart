// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/widgets/field_infinite_scroll.dart';

part 'field_infinite_event.dart';
part 'field_infinite_state.dart';

class FieldInfiniteBloc extends Bloc<FieldInfiniteEvent, FieldInfiniteState> {
  List<FieldInfiniteData> data = [];
  bool isLoading = false;
  bool hasMore = false;

  FieldInfiniteBloc() : super(FieldInfiniteInitial()) {
    on<FieldInfiniteSetData>((event, emit) {
      if (event.data != null) {
        data = event.data!;
      }
      if (event.hasMore != null) {
        hasMore = event.hasMore!;
      }

      emit(FieldInfiniteInitial());
    });
    on<FieldInfiniteSetLoading>(
      (event, emit) {
        isLoading = event.loading;
        emit(
          FieldInfiniteInitial(),
        );
      },
    );
  }
}
