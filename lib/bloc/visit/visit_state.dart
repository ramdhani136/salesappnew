part of 'visit_bloc.dart';

@immutable
abstract class VisitState {}

class VisitInitial extends VisitState {}

class CurrentTab extends VisitState {
  final int tabIndex;

  CurrentTab(this.tabIndex);

  // @override
  // List<Object?> get props => [tabIndex];
}

class IsLoading extends VisitState {}

class IsLoaded extends VisitState {
  List<Visitmodel> data = [];
  int total = 0;
  bool hasMore = false;

  IsLoaded({
    required newData,
    required this.hasMore,
    required this.total,
  }) {
    data = newData;
  }
}

class IsLoadingPage extends VisitState {}

class IsFailure extends VisitState {
  String error;

  IsFailure(this.error);
}
