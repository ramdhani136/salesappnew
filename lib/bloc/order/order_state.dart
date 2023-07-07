// ignore_for_file: must_be_immutable

part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderIsLoading extends OrderState {}

class OrderInfiniteLoading extends OrderState {}

class OrderShowIsLoaded extends OrderState {
  OrderModel data;
  List<dynamic> workflow;
  OrderShowIsLoaded({
    required this.data,
    required this.workflow,
  });
}

class OrderIsFailure extends OrderState {
  String error;
  OrderIsFailure(this.error);
}
