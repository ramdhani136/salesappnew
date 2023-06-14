// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationAddress extends LocationState {
  String? address;
  Position? cordinate;

  LocationAddress(this.address, this.cordinate);
}

class LocationFailure extends LocationState {
  final String error;

  LocationFailure(this.error);
}
