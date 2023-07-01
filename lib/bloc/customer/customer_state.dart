// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'customer_bloc.dart';

@immutable
abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerIsLoading extends CustomerState {}

class CustomerIsFailure extends CustomerState {
  String error;
  CustomerIsFailure(this.error);
}

class CustomerShowLoaded extends CustomerState {
  CustomerModel data;
  CustomerShowLoaded({
    required this.data,
  });
}
