part of 'callsheet_bloc.dart';

@immutable
abstract class CallsheetEvent {}

class CallsheetGetAllData extends CallsheetEvent {
  int status = 0;
  bool pagingRefresh = false;
  String? search;

  CallsheetGetAllData(
      {this.status = 0, this.pagingRefresh = false, this.search});
}

class CallsheetChangeWorkflow extends CallsheetEvent {
  String id;
  String nextStateId;
  CallsheetChangeWorkflow({required this.id, required this.nextStateId});
}

class CallsheetInsert extends CallsheetEvent {
  Map<String, dynamic> data;
  CallsheetInsert({required this.data});
}

class CallsheetShowData extends CallsheetEvent {
  String id;
  bool isLoading;

  CallsheetShowData({required this.id, this.isLoading = true});
}

class CallsheetDeleteOne extends CallsheetEvent {
  String id;

  CallsheetDeleteOne(this.id);
}
