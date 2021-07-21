part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool drawTour;
  final bool followLocation;
  final LatLng centralLocation;

  // Polylines
  final Map<String, Polyline> polylines;

  MapState({
    this.mapReady = false,
    this.drawTour = false,
    this.followLocation = false,
    LatLng? centralLocation,
    Map<String, Polyline>? polylines
  }): 
    this.polylines = polylines ?? new Map(),
    this.centralLocation = centralLocation ?? new LatLng(0, 0);

  MapState copyWith({
    bool? mapReady,
    bool? drawTour,
    bool? followLocation,
    LatLng? centralLocation,
    Map<String, Polyline>? polylines,
  }) => MapState(
    mapReady: mapReady ?? this.mapReady,
    drawTour: drawTour ?? this.drawTour,
    followLocation: followLocation ?? this.followLocation,
    centralLocation: centralLocation ?? this.centralLocation,
    polylines: polylines ?? this.polylines
  );
}
