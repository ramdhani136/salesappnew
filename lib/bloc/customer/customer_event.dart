// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

part of 'customer_bloc.dart';

@immutable
abstract class CustomerEvent {}

class ShowCustomer extends CustomerEvent {
  final String customerId;
  ShowCustomer(this.customerId);
}

class GetAllCustomer extends CustomerEvent {
  bool refresh;
  Nearby? nearby;
  GetAllCustomer({
    this.refresh = true,
    this.nearby,
  });
}

class UpdateCustomer extends CustomerEvent {
  String id;
  Map<String, dynamic> data;
  UpdateCustomer({
    required this.id,
    required this.data,
  });
}

class ChangeImageCustomer extends CustomerEvent {
  String id;
  String? address;
  ChangeImageCustomer({
    required this.id,
    this.address,
  });
}

class Nearby {
  double lat;
  double lng;
  Nearby({required this.lat, required this.lng});
}
