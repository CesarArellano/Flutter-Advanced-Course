import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' show Colors, Offset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/uber_map_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super( MapState() );

  GoogleMapController? mapController;

  // Polylines
  Polyline _myRoute = const Polyline(
    polylineId: PolylineId('my_route'),
    width: 4,
    color: Colors.transparent,
  );

  Polyline _myDestinationRoute = const Polyline(
    polylineId: PolylineId('my_destination_route'),
    width: 4,
    color: Colors.black87,
  );



  void initMap( GoogleMapController controller ) {
    if( !state.mapReady ) {
      mapController = controller;
      mapController!.setMapStyle( jsonEncode(uberMapTheme) );
    }

    add(OnMapReady());
  }

  void moveCamera( LatLng destination ) {
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState( MapEvent event ) async* {
    if( event is OnMapReady ) {
      yield state.copyWith( mapReady: true );
    } else if( event is OnNewLocation) {
      yield* _onNewLocation(event);
    } else if ( event is OnMarkRoute ) {
      yield* _onMarkRoute(event);
    } else if ( event is OnFollowLocation ) {
      yield* _onFollowLocation(event);
    } else if ( event is OnMovedMap ) {
      yield state.copyWith( centralLocation: event.centerMap );
    } else if ( event is OnCreateRouteOriginDestination ) {
      yield*_onCreateRouteOriginDestination(event);
    }
  }

  Stream<MapState> _onNewLocation( OnNewLocation event) async* {

    if( state.followLocation ) {
      moveCamera( event.location );
    }
    
    List<LatLng> points = [ ..._myRoute.points, event.location];
    _myRoute = _myRoute.copyWith( pointsParam: points);
    
    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = _myRoute;
    
    yield state.copyWith( polylines: currentPolylines );
  }

  Stream<MapState> _onMarkRoute( OnMarkRoute event ) async* {
    if( !state.drawTour ) {
        _myRoute = _myRoute.copyWith(colorParam: Colors.black87);
    } else {
      _myRoute = _myRoute.copyWith(colorParam: Colors.transparent);
    }
    
    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = _myRoute;

    yield state.copyWith(drawTour: !state.drawTour, polylines: currentPolylines );
  }

  Stream<MapState> _onFollowLocation( OnFollowLocation event ) async* {
    if( !state.followLocation ) {
      moveCamera( _myRoute.points[ _myRoute.points.length - 1 ] );
    }
    yield state.copyWith(followLocation: !state.followLocation);
  }

  Stream<MapState> _onCreateRouteOriginDestination( OnCreateRouteOriginDestination event ) async* {
    _myDestinationRoute = _myDestinationRoute.copyWith(
      pointsParam: event.routeCoords,
    );

    final currentPolylines = state.polylines;
    currentPolylines['my_destination_route'] = _myDestinationRoute;
    
    final coordsList = event.routeCoords;
    
    // Custom Icons
    // final originIcon = await getAssetImageMarker();
    final originIcon = await getMarkerOriginIcon( event.duration.toInt() );
    // final destinationIcon = await getNetworkImageMarker();
    final destinationIcon = await getMarkerDestinationIcon(event.destinationName, event.distance);

    // Markers
    final originMarker = Marker(
      markerId: const MarkerId('origin'),
      position: coordsList[0],
      icon: originIcon,  
      anchor: const Offset(0.0, 1.0),
      infoWindow: InfoWindow(
        title: 'My Location',
        snippet: 'Tour duration: ${ (event.duration / 60).floor() } minutes'
      )
    );

    double distanceKm = event.distance / 1000;
    distanceKm = (distanceKm * 100).floor().toDouble();
    distanceKm = distanceKm / 100;

    final destinationMarker = Marker(
      markerId: const MarkerId('destination'),
      position: coordsList[coordsList.length - 1],
      icon: destinationIcon,
      anchor: const Offset(0.1, 0.95),
      infoWindow: InfoWindow(
        title: event.destinationName,
        snippet: 'Distance: $distanceKm  km'
      )
      
    );

    final newMarkers = { ...state.markers };
    newMarkers['origin'] = originMarker;
    newMarkers['destination'] = destinationMarker;

    Future.delayed(const Duration(milliseconds: 300)).then(
      (value) => mapController!.showMarkerInfoWindow(const MarkerId('destination')),
    );

    yield state.copyWith(
      polylines: currentPolylines,
      markers: newMarkers
    );
  }
}
