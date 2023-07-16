// ignore_for_file: non_constant_identifier_names, must_be_immutable

part of 'callsheetnote_bloc.dart';

@immutable
abstract class CallsheetnoteState {}

class CallsheetnoteInitial extends CallsheetnoteState {}

class CallsheetNoteIsLoading extends CallsheetnoteState {}

class CallsheetNoteIsLoaded extends CallsheetnoteState {
  List<CallsheetNoteModel> data;
  bool hasMore;
  int page;
  int total;
  bool IsloadingPage;

  CallsheetNoteIsLoaded({
    required this.data,
    this.hasMore = false,
    this.page = 1,
    this.total = 1,
    this.IsloadingPage = false,
  });
}

class CallsheetNoteShow extends CallsheetnoteState {
  Map data;
  CallsheetNoteShow({required this.data});
}

class CallsheetNoteDeleteSuccess extends CallsheetnoteState {}

class CallsheetNoteIsFailure extends CallsheetnoteState {
  String error;
  CallsheetNoteIsFailure(this.error);
}
