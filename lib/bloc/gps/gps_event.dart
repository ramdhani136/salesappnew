// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'gps_bloc.dart';

@immutable
abstract class GpsEvent {}

class GpsGetLocation extends GpsEvent {
  int? distanceFilter;
  String? customer;

  GpsGetLocation({
    this.distanceFilter,
    this.customer,
  });
}

class GpsSetLocation extends GpsEvent {
  Position position;

  GpsSetLocation(
    this.position,
  );
}

class GpsSetCheckInOut extends GpsEvent {
  Position position;
  String customer;
  Uint8List markerIcon;
  Uint8List customerIcon;
  Map<String, dynamic> config;
  GpsSetCheckInOut({
    required this.position,
    required this.customer,
    required this.config,
    required this.customerIcon,
    required this.markerIcon,
  });
}

class GpsStopLocation extends GpsEvent {}
