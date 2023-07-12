// ignore_for_file: must_be_immutable

part of 'group_bloc.dart';

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupIsLoaded extends GroupState {
  List<GroupModel> data = [];
  int total;
  bool hasMore;
  bool pageLoading;

  GroupIsLoaded({
    required this.data,
    this.hasMore = false,
    this.total = 0,
    this.pageLoading = false,
  });
}

class GroupIsLoading extends GroupState {}

class GroupIsFailure extends GroupState {
  String error;
  GroupIsFailure(this.error);
}

class GroupTokenExpired extends GroupState {
  String error;

  GroupTokenExpired(this.error);
}
