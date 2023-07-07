// ignore_for_file: must_be_immutable

part of 'item_bloc.dart';

@immutable
abstract class ItemEvent {}

class GetItemShow extends ItemEvent {
  String id;
  GetItemShow({
    required this.id,
  });
}

class ItemGetAll extends ItemEvent {
  int status = 0;
  bool getRefresh = false;
  String? search;

  ItemGetAll({this.status = 0, this.getRefresh = false, this.search});
}

class ItemChangeSearch extends ItemEvent {
  String search = "";

  ItemChangeSearch(this.search);
}
