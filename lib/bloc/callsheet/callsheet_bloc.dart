import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/action_model.dart';
import 'package:salesappnew/models/task_callsheet_model.dart';
import 'package:salesappnew/models/history_model.dart';
import 'package:salesappnew/models/callsheet_model.dart';

part 'callsheet_event.dart';
part 'callsheet_state.dart';

class CallsheetBloc extends Bloc<CallsheetEvent, CallsheetState> {
  CallsheetBloc() : super(CallsheetInitial()) {
    on<CallsheetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
