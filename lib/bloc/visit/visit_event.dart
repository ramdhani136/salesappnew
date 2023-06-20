part of 'visit_bloc.dart';

@immutable
abstract class VisitEvent {}

class GetData extends VisitEvent {
  int status = 0;
  bool getRefresh = false;
  String? search;

  GetData({this.status = 0, this.getRefresh = false, this.search});
}
