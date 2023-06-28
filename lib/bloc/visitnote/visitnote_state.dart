// ignore_for_file: must_be_immutable

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

  VisitNoteIsLoaded({
    required this.data,
    this.hasMore = false,
    this.page = 1,
    this.total = 1,
  });
}

class VisitNoteIsFailure extends VisitnoteState {
  String error;
  VisitNoteIsFailure(this.error);
}
