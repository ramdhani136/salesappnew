// ignore_for_file: must_be_immutable

part of 'callsheet_bloc.dart';

@immutable
abstract class CallsheetState {}

class CallsheetInitial extends CallsheetState {}

class CallsheetIsLoading extends CallsheetState {}

class CallsheetIsLoaded extends CallsheetState {
  List<CallsheetModel> data = [];
  int total = 0;
  bool hasMore = false;
  bool pageLoading = false;
  int page;
  CallsheetIsLoaded({
    required newData,
    required this.hasMore,
    required this.total,
    required this.pageLoading,
    this.page = 1,
  }) {
    data = newData;
  }
}

class CallsheetIsShowLoaded extends CallsheetState {
  CallsheetModel data;
  List<HistoryModel> history;
  List<ActionModel> workflow;
  List<TaskCallsheetModel> task;
  CallsheetIsShowLoaded({
    required this.data,
    required this.history,
    required this.workflow,
    required this.task,
  });
}

class CallsheetIsLoadingPage extends CallsheetState {}

class CallsheetIsFailure extends CallsheetState {
  String error;

  CallsheetIsFailure(this.error);
}

class CallsheetDeleteFailure extends CallsheetState {
  String error;

  CallsheetDeleteFailure(this.error);
}

class CallsheetDeleteSuccess extends CallsheetState {}

class CallsheetTokenExpired extends CallsheetState {
  String error;

  CallsheetTokenExpired(this.error);
}
