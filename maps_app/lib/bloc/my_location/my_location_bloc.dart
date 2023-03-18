import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'my_location_event.dart';
part 'my_location_state.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  MyLocationBloc() : super( const MyLocationState() );
  
  StreamSubscription<geolocator.Position>? _positionSubscription;

  void startTracking() {
    _positionSubscription = geolocator.Geolocator.getPositionStream(
      locationSettings: const geolocator.LocationSettings(
        accuracy: geolocator.LocationAccuracy.high,
        distanceFilter: 10
      )
    ).listen( ( geolocator.Position position ) {
      final newLocation = LatLng(position.latitude, position.longitude);
      add(OnLocationChanged(newLocation));
    });
  }

  void disposeTracking() {
    _positionSubscription?.cancel();
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
