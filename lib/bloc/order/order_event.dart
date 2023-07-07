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

class OrderGetAll extends OrderEvent {
  int status = 0;
  bool getRefresh = false;
  String? search;

  OrderGetAll({this.status = 0, this.getRefresh = false, this.search});
}

class OrderChangeSearch extends OrderEvent {
  String search = "";

  OrderChangeSearch(this.search);
}
