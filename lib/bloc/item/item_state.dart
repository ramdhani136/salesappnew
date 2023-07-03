part of 'item_bloc.dart';

@immutable
abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemIsLoading extends ItemState {}

class ItemInfiniteLoading extends ItemState {}

class ItemShowIsLoaded extends ItemState {
  ItemModel data;
  List<dynamic> workflow;
  ItemShowIsLoaded({
    required this.data,
    required this.workflow,
  });
}

class ItemIsFailure extends ItemState {
  String error;
  ItemIsFailure(this.error);
}
