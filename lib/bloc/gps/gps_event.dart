// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'gps_bloc.dart';

@immutable
abstract class GpsEvent {}

class CheckInOut {
  String? customer;

  CheckInOut({this.customer});
}

class GpsGetLocation extends GpsEvent {
  int? distanceFilter;
  CheckInOut? checkInOut;

  GpsGetLocation({
    this.distanceFilter,
    this.checkInOut,
  });
}

class GpsSetLocation extends GpsEvent {
  Position position;

  GpsSetLocation(
    this.position,
  );
}

class GpsSetError extends GpsEvent {
  String msg;

  GpsSetError(
    this.msg,
  );
}

class GpsSetCheckInOut extends GpsEvent {
  Position position;
  String? customer;
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
