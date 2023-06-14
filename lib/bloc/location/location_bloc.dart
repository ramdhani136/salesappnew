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
      if (event is getCordinateGps) {
        // try {
        //   emit(LocationLoading());
        //   cordinates = await location.CheckLocation();

        //   emit(LocationInitial());
        // } catch (e) {
        //   emit(LocationFailure(e.toString()));
        // }
      } else if (event is getAddress) {
        try {
          emit(LocationLoading());
          String address = await location.chekcAdress();
          emit(LocationAddress(address));
        } catch (e) {
          emit(LocationFailure(e.toString()));
        }
      }
    });
  }
}
