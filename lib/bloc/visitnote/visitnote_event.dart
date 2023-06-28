part of 'visitnote_bloc.dart';

@immutable
abstract class VisitnoteEvent {}

class GetVisitNote extends VisitnoteEvent {
  String visitId;
  GetVisitNote(this.visitId);
}
