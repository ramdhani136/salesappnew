// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'memo_bloc.dart';

@immutable
abstract class MemoEvent {}

class MemoGetAllData extends MemoEvent {
  int? status;
  bool getRefresh;
  String? search;
  int? limit;
  List<List<String>>? filters;
  MemoGetAllData({
    this.status,
    this.limit,
    this.getRefresh = true,
    this.search,
    this.filters,
  });
}
