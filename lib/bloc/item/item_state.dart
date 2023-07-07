// ignore_for_file: must_be_immutable

part of 'item_bloc.dart';

@immutable
abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemIsLoading extends ItemState {}

class ItemInfiniteLoading extends ItemState {}

class ItemShowIsLoaded extends ItemState {
  String? erpUrl;
  ItemModel data;
  List<dynamic> workflow;
  ItemShowIsLoaded({
    required this.data,
    required this.workflow,
    this.erpUrl,
  });
}

class ItemIsFailure extends ItemState {
  String error;
  ItemIsFailure(this.error);
}

class ItemIsLoaded extends ItemState {
  List data;
  bool hasMore;
  bool pageLoading;
  String erpUri;

  ItemIsLoaded({
    required this.data,
    this.hasMore = false,
    this.pageLoading = false,
    required this.erpUri,
  });
}

class ItemTokenExpired extends ItemState {
  String error;

  ItemTokenExpired(this.error);
}
