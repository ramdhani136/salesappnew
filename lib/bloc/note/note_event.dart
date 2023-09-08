// ignore_for_file: must_be_immutable

part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

enum Doc { visit, callsheet }

class NoteGetData extends NoteEvent {
  String docId;
  Doc doc;
  bool refresh;
  NoteGetData({
    required this.docId,
    this.refresh = true,
    this.doc = Doc.visit,
  });
}

class NoteShowData extends NoteEvent {
  String id;
  bool isLoading;
  NoteShowData({
    required this.id,
    this.isLoading = true,
  });
}

class NoteDeleteData extends NoteEvent {
  String id;
  NoteDeleteData({
    required this.id,
  });
}

class NoteUpdateData extends NoteEvent {
  String id;
  Map<String, dynamic> data;
  NoteUpdateData({
    required this.id,
    required this.data,
  });
}

class NoteAddData extends NoteEvent {
  Map<String, dynamic> data;
  NoteAddData({
    required this.data,
  });
}

class NoteAddTag extends NoteEvent {
  KeyValue tag;
  NoteAddTag({
    required this.tag,
  });
}

class NoteRemoveTag extends NoteEvent {
  KeyValue tag;
  NoteRemoveTag({
    required this.tag,
  });
}
