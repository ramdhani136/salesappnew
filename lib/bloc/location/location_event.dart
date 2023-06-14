part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class getCordinateGps extends LocationEvent {}

class getAddress extends LocationEvent {}
