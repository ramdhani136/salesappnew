// ignore_for_file: must_be_immutable

part of 'tags_bloc.dart';

@immutable
abstract class TagsEvent {}

class TagGetAll extends TagsEvent {
  bool refresh;
  List<List<String>>? filters;
  String? search;
  int limit;
  TagGetAll({
    this.refresh = true,
    this.filters,
    this.search,
    this.limit = 10,
  });
}

class TagChangeSearch extends TagsEvent {
  String search = "";

  TagChangeSearch(this.search);
}

class TagInsert extends TagsEvent {
  Map<String, dynamic> data;
  TagInsert({required this.data});
}
