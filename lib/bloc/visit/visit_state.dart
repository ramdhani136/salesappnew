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
