import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'my_location_event.dart';
part 'my_location_state.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  MyLocationBloc() : super(MyLocationState());
  
  StreamSubscription<Geolocator.Position>? _positionSubscription;

  void startTracking() {
    this._positionSubscription = Geolocator.Geolocator.getPositionStream(
      desiredAccuracy: Geolocator.LocationAccuracy.high,
      distanceFilter: 10,
    ).listen( ( Geolocator.Position position ) {
      final newLocation = new LatLng(position.latitude, position.longitude);
      add(OnLocationChanged(newLocation));
    });
  }

  void disposeTracking() {
    this._positionSubscription?.cancel();
  }

  @override
  Stream<MyLocationState> mapEventToState( MyLocationEvent event ) async* {
    if( event is OnLocationChanged ) {
      yield state.copyWith(
        existLocation: true,
        location: event.location
      );
    }
  }
}
