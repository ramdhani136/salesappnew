// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/utils/location_gps.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationGps location = LocationGps();
  String? address;
  Position? cordinate;

  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) async {
      if (event is GetLocationGps) {
        try {
          if (event.loading) {
            emit(LocationLoading());
          }
          cordinate = await location.CheckLocation();
          if (cordinate != null) {
            address = await location.chekcAdress(cordinate!);
            emit(LocationLoaded());
          }
        } catch (e) {
          emit(LocationFailure(e.toString()));
        }
      }
      if (event is GetRealtimeGps) {
        try {
          await Future.delayed(event.duration);
          // emit(LocationLoading());
          cordinate = await location.CheckLocation();
          if (cordinate != null) {
            address = await location.chekcAdress(cordinate!);
            emit(LocationLoaded());
          }
        } catch (e) {
          emit(LocationFailure(e.toString()));
        }
      }
    });
  }
}
