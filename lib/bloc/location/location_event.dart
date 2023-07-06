// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: must_be_immutable

part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class GetLocationGps extends LocationEvent {
  bool loading = true;
  String? customerId;
  GetLocationGps({bool? notLoading, this.customerId}) {
    if (notLoading != null) {
      loading = false;
    }
  }
}

class GetRealtimeGps extends LocationEvent {
  Duration duration;
  String? customerId;
  GetRealtimeGps({required this.duration, this.customerId});
}

class Cordinate {
  double lat;
  double lng;
  Cordinate({
    required this.lat,
    required this.lng,
  });
}
