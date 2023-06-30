// ignore_for_file: must_be_immutable, non_constant_identifier_names

part of 'visitnote_bloc.dart';

@immutable
abstract class VisitnoteState {}

class VisitnoteInitial extends VisitnoteState {}

class VisitNoteIsLoading extends VisitnoteState {}

class VisitNoteIsLoaded extends VisitnoteState {
  List<VisitNoteModel> data;
  bool hasMore;
  int page;
  int total;
  bool IsloadingPage;

  VisitNoteIsLoaded({
    required this.data,
    this.hasMore = false,
    this.page = 1,
    this.total = 1,
    this.IsloadingPage = false,
  });
}

class VisitNoteShow extends VisitnoteState {
  Map data;
  VisitNoteShow({required this.data});
}

class VisitNoteIsFailure extends VisitnoteState {
  String error;
  VisitNoteIsFailure(this.error);
}
