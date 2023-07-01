part of 'customer_bloc.dart';

@immutable
abstract class CustomerEvent {}

class ShowCustomer extends CustomerEvent {
  final String customerId;
  ShowCustomer(this.customerId);
}
