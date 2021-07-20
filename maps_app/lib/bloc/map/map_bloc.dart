import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super( new MapState() );

  GoogleMapController? mapController;

  void initMap( GoogleMapController controller ) {
    if( !state.mapReady ) {
      this.mapController = controller;
      this.mapController!.setMapStyle( jsonEncode(uberMapTheme) );
    }

    add(OnMapReady());
  }

  void moveCamera( LatLng destination ) {
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    this.mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState( MapEvent event ) async* {
    if( event is OnMapReady ) {
      print('Map ready');
      yield state.copyWith( mapReady: true );
    }
  }
}
