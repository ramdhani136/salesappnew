part of 'visit_bloc.dart';

@immutable
abstract class VisitEvent {}

class GetData extends VisitEvent {
  int status = 0;
  GetData({int? status}) {
    if (status != null) {
      this.status = status;
    }
  }
}
