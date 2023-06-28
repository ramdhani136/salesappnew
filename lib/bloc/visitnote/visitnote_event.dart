part of 'visitnote_bloc.dart';

@immutable
abstract class VisitnoteEvent {}

class GetVisitNote extends VisitnoteEvent {
  String visitId;
  bool refresh;
  GetVisitNote({
    required this.visitId,
    this.refresh = true,
  });
}
