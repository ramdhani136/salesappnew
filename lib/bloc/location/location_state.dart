// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, non_constant_identifier_names
part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  BitmapDescriptor? IconEtmMaps;
  BitmapDescriptor? IconCustomerMaps;
  num? distanceCheckIn;
  num? distanceCheckOut;
  // Position? cordinate;

  LocationLoaded({
    this.IconEtmMaps = BitmapDescriptor.defaultMarker,
    this.IconCustomerMaps = BitmapDescriptor.defaultMarker,
    this.distanceCheckIn,
    this.distanceCheckOut,
  });
}

class LocationFailure extends LocationState {
  final String error;

  LocationFailure(this.error);
}
