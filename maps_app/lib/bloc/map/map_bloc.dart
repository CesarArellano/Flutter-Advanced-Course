import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' show Colors;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/uber_map_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super( new MapState() );

  GoogleMapController? mapController;

  // Polylines
  Polyline _myRoute = new Polyline(
    polylineId: PolylineId('my_route'),
    width: 4,
    color: Colors.transparent
  );

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
      yield state.copyWith( mapReady: true );
    } else if( event is OnNewLocation) {
      yield* this._onNewLocation(event);
    } else if ( event is OnMarkRoute ) {
      yield* this._onMarkRoute(event);
    } else if ( event is OnFollowLocation ) {
      yield* this._onFollowLocation(event);
    } else if ( event is OnMovedMap ) {
      yield state.copyWith( centralLocation: event.centerMap );
    }
  }

  Stream<MapState> _onNewLocation( OnNewLocation event) async* {

    if( state.followLocation ) {
      this.moveCamera( event.location );
    }
    
    List<LatLng> points = [ ...this._myRoute.points, event.location];
    this._myRoute = this._myRoute.copyWith( pointsParam: points);
    
    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;
    
    yield state.copyWith( polylines: currentPolylines );
  }

  Stream<MapState> _onMarkRoute( OnMarkRoute event ) async* {
    if( !state.drawTour ) {
        this._myRoute = this._myRoute.copyWith(colorParam: Colors.black87);
    } else {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
    }
    
    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;

    yield state.copyWith(drawTour: !state.drawTour, polylines: currentPolylines );
  }

  Stream<MapState> _onFollowLocation( OnFollowLocation event ) async* {
    if( !state.followLocation ) {
      this.moveCamera( this._myRoute.points[ this._myRoute.points.length - 1 ] );
    }
    yield state.copyWith(followLocation: !state.followLocation);
  }
}
