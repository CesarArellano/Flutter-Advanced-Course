part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapReady extends MapEvent { }

class OnMarkRoute extends MapEvent {}

class OnFollowLocation extends MapEvent {}

class OnCreateRouteOriginDestination extends MapEvent {
  
  final List<LatLng> routeCoords;
  final double distance;
  final double duration;
  final String destinationName;

  OnCreateRouteOriginDestination(this.routeCoords, this.distance, this.duration, this.destinationName);

}

class OnMovedMap extends MapEvent {
  final LatLng centerMap;
  OnMovedMap(this.centerMap);
}

class OnNewLocation extends MapEvent {
  final LatLng location;
  OnNewLocation(this.location);
}

