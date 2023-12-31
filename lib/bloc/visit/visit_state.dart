// ignore_for_file: must_be_immutable

part of 'visit_bloc.dart';

@immutable
abstract class VisitState {}

class VisitInitial extends VisitState {}

class IsLoading extends VisitState {}

class IsLoaded extends VisitState {
  List<Visitmodel> data = [];
  int total = 0;
  bool hasMore = false;
  bool pageLoading = false;

  IsLoaded(
      {required newData,
      required this.hasMore,
      required this.total,
      required this.pageLoading}) {
    data = newData;
  }
}

class IsShowLoaded extends VisitState {
  Visitmodel data;
  List<HistoryModel> history;
  List<ActionModel> workflow;
  List<TaskVisitModel> task;

  IsShowLoaded({
    required this.data,
    required this.history,
    required this.workflow,
    required this.task,
  });

  IsShowLoaded copyWith({
    Visitmodel? data,
    List<HistoryModel>? history,
    List<ActionModel>? workflow,
    List<TaskVisitModel>? task,
  }) {
    return IsShowLoaded(
      data: data ?? this.data,
      history: history ?? this.history,
      workflow: workflow ?? this.workflow,
      task: task ?? this.task,
    );
  }
}

class IsLoadingPage extends VisitState {}

class IsFailure extends VisitState {
  String error;

  IsFailure(this.error);
}

class DeleteFailure extends VisitState {
  String error;

  DeleteFailure(this.error);
}

class DeleteSuccess extends VisitState {}

class TokenExpired extends VisitState {
  String error;

  TokenExpired(this.error);
}
