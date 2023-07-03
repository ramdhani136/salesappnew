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
