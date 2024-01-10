// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'gps_bloc.dart';

@immutable
sealed class GpsState {}

final class GpsInitial extends GpsState {}

final class GpsIsLoading extends GpsState {}

class GpsIsFailure extends GpsState {
  String error;
  GpsIsFailure(this.error);
}

class GpsIsLoaded extends GpsState {
  Position data;
  GpsIsLoaded({
    required this.data,
  });
}
