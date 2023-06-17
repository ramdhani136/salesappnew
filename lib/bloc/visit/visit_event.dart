part of 'visit_bloc.dart';

@immutable
abstract class VisitEvent {}

class TabChanged extends VisitEvent {
  final int tabIndex;

  TabChanged(this.tabIndex);

  // @override
  // List<Object?> get props => [tabIndex];
}

class GetData extends VisitEvent {}
