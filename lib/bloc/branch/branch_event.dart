// ignore_for_file: must_be_immutable

part of 'branch_bloc.dart';

@immutable
abstract class BranchEvent {}

class BranchGetAll extends BranchEvent {
  List<String>? fields;
  List<List<String>>? filters;
  String? orderBy;
  String? search;
  String? params;
  int page;
  int limit;

  BranchGetAll({
    this.fields,
    this.filters,
    this.limit = 0,
    this.page = 1,
    this.orderBy,
    this.search,
  });
}
