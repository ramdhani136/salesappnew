// ignore_for_file: must_be_immutable

part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class GetLocationGps extends LocationEvent {}

class GetRealtimeGps extends LocationEvent {
  Duration duration;
  GetRealtimeGps({required this.duration});
}
