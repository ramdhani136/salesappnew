// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

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

class ShowVisitNote extends VisitnoteEvent {
  String id;
  bool isLoading;
  ShowVisitNote({
    required this.id,
    this.isLoading = true,
  });
}

class DeleteVisitNote extends VisitnoteEvent {
  String id;
  DeleteVisitNote({
    required this.id,
  });
}

class UpdateVisitNote extends VisitnoteEvent {
  String id;
  Map<String, dynamic> data;
  UpdateVisitNote({
    required this.id,
    required this.data,
  });
}

class InsertVisitNote extends VisitnoteEvent {
  Map<String, dynamic> data;
  InsertVisitNote({
    required this.data,
  });
}

class VisitNoteAddTag extends VisitnoteEvent {
  KeyValue tag;
  VisitNoteAddTag({
    required this.tag,
  });
}

class VisitNoteRemoveTag extends VisitnoteEvent {
  KeyValue tag;
  VisitNoteRemoveTag({
    required this.tag,
  });
}
