// ignore_for_file: must_be_immutable

part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class GetOrdershow extends OrderEvent {
  String id;
  GetOrdershow({
    required this.id,
  });
}
