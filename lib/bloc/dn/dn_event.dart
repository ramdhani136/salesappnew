// ignore_for_file: must_be_immutable

part of 'dn_bloc.dart';

@immutable
abstract class DnEvent {}

class GetDnShow extends DnEvent {
  String id;
  GetDnShow({
    required this.id,
  });
}

class DnGetAll extends DnEvent {
  int status = 0;
  bool getRefresh = false;
  String? search;

  DnGetAll({this.status = 0, this.getRefresh = false, this.search});
}

class DnChangeSearch extends DnEvent {
  String search = "";

  DnChangeSearch(this.search);
}
