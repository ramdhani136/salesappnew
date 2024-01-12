// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, non_constant_identifier_names
part of 'gps_bloc.dart';

@immutable
abstract class GpsState {}

final class GpsInitial extends GpsState {}

final class GpsIsLoading extends GpsState {}

class GpsIsFailure extends GpsState {
  String error;
  GpsIsFailure(this.error);
}

class GpsIsLoaded extends GpsState {
  final Position position;
  GpsIsLoaded(
    this.position,
  );
}

class GpsCheckInOutIsLoaded extends GpsState {
  BitmapDescriptor? IconEtmMaps;
  BitmapDescriptor? IconCustomerMaps;
  num? distanceCheckIn;
  num? distanceCheckOut;
  bool? insite;
  Position position;

  GpsCheckInOutIsLoaded({
    this.IconEtmMaps = BitmapDescriptor.defaultMarker,
    this.IconCustomerMaps = BitmapDescriptor.defaultMarker,
    this.distanceCheckIn,
    this.distanceCheckOut,
    this.insite,
    required this.position,
  });
}
