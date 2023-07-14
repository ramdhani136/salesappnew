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
  List<List<String>>? filters;
  String? search;
  GetAllCustomer({
    this.refresh = true,
    this.nearby,
    this.filters,
    this.search,
  });
}

class CustomerChangeSearch extends CustomerEvent {
  String search = "";

  CustomerChangeSearch(this.search);
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

  ChangeImageCustomer({
    required this.id,
  });
}

class Nearby {
  double lat;
  double lng;
  Nearby({required this.lat, required this.lng});
}

class CustomerSetForm extends CustomerEvent {
  KeyValue? group;
  KeyValue? name;
  KeyValue? branch;

  CustomerSetForm({
    this.group,
    this.name,
    this.branch,
  });
}

class CustomerResetForm extends CustomerEvent {
  bool group;
  bool name;
  bool branch;

  CustomerResetForm({
    this.name = false,
    this.branch = false,
    this.group = false,
  });
}

class CustomerInsert extends CustomerEvent {
  Map<String, dynamic> data;
  CustomerInsert({required this.data});
}
