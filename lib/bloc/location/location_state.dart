// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  BitmapDescriptor? IconEtmMaps;
  BitmapDescriptor? IconCustomerMaps;
  // Position? cordinate;

  LocationLoaded({
    this.IconEtmMaps = BitmapDescriptor.defaultMarker,
    this.IconCustomerMaps = BitmapDescriptor.defaultMarker,
  });
}

class LocationFailure extends LocationState {
  final String error;

  LocationFailure(this.error);
}
