// ignore_for_file: must_be_immutable

part of 'dn_bloc.dart';

@immutable
abstract class DnState {}

class DnInitial extends DnState {}

class DnIsLoading extends DnState {}

class OrderInfiniteLoading extends DnState {}

class DnShowIsLoaded extends DnState {
  DnModel data;
  List<dynamic> workflow;
  DnShowIsLoaded({
    required this.data,
    required this.workflow,
  });
}

class DnIsFailure extends DnState {
  String error;
  DnIsFailure(this.error);
}

class DnIsLoaded extends DnState {
  List data;
  bool hasMore;
  bool pageLoading;

  DnIsLoaded({
    required this.data,
    this.hasMore = false,
    this.pageLoading = false,
  });
}

class DnTokenExpired extends DnState {
  String error;

  DnTokenExpired(this.error);
}
