import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' show Colors, Offset;
import 'package:bloc/bloc.dart';
import 'package:maps_app/helpers/helpers.dart';
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
    color: Colors.transparent,
  );

  Polyline _myDestinationRoute = new Polyline(
    polylineId: PolylineId('my_destination_route'),
    width: 4,
    color: Colors.black87,
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
    } else if ( event is OnCreateRouteOriginDestination ) {
      yield*_onCreateRouteOriginDestination(event);
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

  Stream<MapState> _onCreateRouteOriginDestination( OnCreateRouteOriginDestination event ) async* {
    this._myDestinationRoute = this._myDestinationRoute.copyWith(
      pointsParam: event.routeCoords,
    );

    final currentPolylines = state.polylines;
    currentPolylines['my_destination_route'] = this._myDestinationRoute;
    
    final coordsList = event.routeCoords;
    
    // Custom Icons
    // final originIcon = await getAssetImageMarker();
    final originIcon = await getMarkerOriginIcon( event.duration.toInt() );
    // final destinationIcon = await getNetworkImageMarker();
    final destinationIcon = await getMarkerDestinationIcon(event.destinationName, event.distance);

    // Markers
    final originMarker = new Marker(
      markerId: MarkerId('origin'),
      position: coordsList[0],
      icon: originIcon,  
      anchor: Offset(0.0, 1.0),
      infoWindow: InfoWindow(
        title: 'My Location',
        snippet: 'Tour duration: ${ (event.duration / 60).floor() } minutes'
      )
    );

    double distanceKm = event.distance / 1000;
    distanceKm = (distanceKm * 100).floor().toDouble();
    distanceKm = distanceKm / 100;

    final destinationMarker = new Marker(
      markerId: MarkerId('destination'),
      position: coordsList[coordsList.length - 1],
      icon: destinationIcon,
      anchor: Offset(0.1, 0.95),
      infoWindow: InfoWindow(
        title: event.destinationName,
        snippet: 'Distance: ${ distanceKm } km'
      )
      
    );

    final newMarkers = { ...state.markers };
    newMarkers['origin'] = originMarker;
    newMarkers['destination'] = destinationMarker;

    Future.delayed(Duration(milliseconds: 300)).then(
      (value) => mapController!.showMarkerInfoWindow(MarkerId('destination')),
    );

    yield state.copyWith(
      polylines: currentPolylines,
      markers: newMarkers
    );
  }
}
