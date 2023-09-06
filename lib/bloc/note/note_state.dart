// ignore_for_file: must_be_immutable, non_constant_identifier_names

part of 'note_bloc.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteIsLoading extends NoteState {}

class NoteIsLoaded extends NoteState {
  List<NoteModel> data;
  bool hasMore;
  int page;
  int total;
  bool IsloadingPage;

  NoteIsLoaded({
    required this.data,
    this.hasMore = false,
    this.page = 1,
    this.total = 1,
    this.IsloadingPage = false,
  });
}

class NoteShowIsLoaded extends NoteState {
  Map data;
  NoteShowIsLoaded({required this.data});

  NoteShowIsLoaded copyWith({
    Map? data,
  }) {
    return NoteShowIsLoaded(
      data: data ?? this.data,
    );
  }
}

class NoteDeleteSuccess extends NoteState {}

class NoteIsFailure extends NoteState {
  String error;
  NoteIsFailure(this.error);
}
