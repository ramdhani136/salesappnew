import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/widgets/field_infinite_scroll.dart';

part 'field_infinite_event.dart';
part 'field_infinite_state.dart';

class FieldInfiniteBloc extends Bloc<FieldInfiniteEvent, FieldInfiniteState> {
  List<FieldInfiniteData> data = [];

  FieldInfiniteBloc() : super(FieldInfiniteInitial()) {
    on<FieldInfiniteSetData>((event, emit) {
      if (event.data != null) {
        data = event.data!;
      }

      emit(FieldInfiniteInitial());
    });
  }
}
