import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/utils/location_gps.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationGps location = LocationGps();
  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) async {
      if (event is GetLocationGps) {
        try {
          emit(LocationLoading());
          Position? loc = await location.CheckLocation();
          if (loc != null) {
            String address = await location.chekcAdress(loc);
            emit(LocationAddress(address, loc));
          }
        } catch (e) {
          emit(LocationFailure(e.toString()));
        }
      }
      if (event is GetRealtimeGps) {
        try {
          await Future.delayed(event.duration);
          emit(LocationLoading());
          Position? loc = await location.CheckLocation();
          if (loc != null) {
            String address = await location.chekcAdress(loc);
            emit(LocationAddress(address, loc));
          }
        } catch (e) {
          emit(LocationFailure(e.toString()));
        }
      }
    });
  }
}
