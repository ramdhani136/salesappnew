// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'gps_bloc.dart';

@immutable
abstract class GpsEvent {}

class GpsGetLocation extends GpsEvent {
  int? distanceFilter;

  GpsGetLocation({
    this.distanceFilter,
  });
}

class GpsSetLocation extends GpsEvent {
  Position position;

  GpsSetLocation(
    this.position,
  );
}

class GpsStopLocation extends GpsEvent {}
