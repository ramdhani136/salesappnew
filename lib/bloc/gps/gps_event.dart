// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'gps_bloc.dart';

@immutable
sealed class GpsEvent {}

class GpsGetLocation extends GpsEvent {
  int? distanceFilter;

  GpsGetLocation({
    this.distanceFilter,
  });
}
