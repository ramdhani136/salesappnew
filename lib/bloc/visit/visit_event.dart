// ignore_for_file: must_be_immutable

part of 'visit_bloc.dart';

@immutable
abstract class VisitEvent {}

class GetData extends VisitEvent {
  int status = 0;
  bool getRefresh = false;
  String? search;

  GetData({this.status = 0, this.getRefresh = false, this.search});
}

class ChangeSearch extends VisitEvent {
  String search = "";

  ChangeSearch(this.search);
}

class ShowData extends VisitEvent {
  String id;

  ShowData(this.id);
}

class DeleteOne extends VisitEvent {
  String id;

  DeleteOne(this.id);
}

class ChangeWorkflow extends VisitEvent {
  String id;
  String nextStateId;
  ChangeWorkflow({required this.id, required this.nextStateId});
}
