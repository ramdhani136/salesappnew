// ignore_for_file: must_be_immutable

part of 'callsheetnote_bloc.dart';

@immutable
abstract class CallsheetnoteEvent {}

class GetCallsheetNote extends CallsheetnoteEvent {
  String callsheetId;
  bool refresh;
  GetCallsheetNote({
    required this.callsheetId,
    this.refresh = true,
  });
}

class ShowCallsheetNote extends CallsheetnoteEvent {
  String id;
  bool isLoading;
  ShowCallsheetNote({
    required this.id,
    this.isLoading = true,
  });
}

class DeleteCallsheetNote extends CallsheetnoteEvent {
  String id;
  DeleteCallsheetNote({
    required this.id,
  });
}

class UpdateCallsheetNote extends CallsheetnoteEvent {
  String id;
  Map<String, dynamic> data;
  UpdateCallsheetNote({
    required this.id,
    required this.data,
  });
}

class InsertCallsheetNote extends CallsheetnoteEvent {
  Map<String, dynamic> data;
  InsertCallsheetNote({
    required this.data,
  });
}

class CallsheetNoteAddTag extends CallsheetnoteEvent {
  KeyValue tag;
  CallsheetNoteAddTag({
    required this.tag,
  });
}

class CallsheetNoteRemoveTag extends CallsheetnoteEvent {
  KeyValue tag;
  CallsheetNoteRemoveTag({
    required this.tag,
  });
}
