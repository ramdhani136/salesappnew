// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'group_bloc.dart';

@immutable
abstract class GroupEvent {}

class GroupGetData extends GroupEvent {
  List<List<String>>? filters;
  bool getRefresh;
  String search;
  GroupGetData({
    this.getRefresh = true,
    this.search = "",
    this.filters,
  });
}

class GroupChangeSearch extends GroupEvent {
  String search = "";

  GroupChangeSearch(this.search);
}
