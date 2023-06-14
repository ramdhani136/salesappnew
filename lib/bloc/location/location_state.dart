// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationAddress extends LocationState {
  String? address;

  LocationAddress(
    this.address,
  );
}

class LocationFailure extends LocationState {
  final String error;

  LocationFailure(this.error);
}
