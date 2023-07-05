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

class Nearby {
  double lat;
  double lng;
  Nearby({required this.lat, required this.lng});
}
