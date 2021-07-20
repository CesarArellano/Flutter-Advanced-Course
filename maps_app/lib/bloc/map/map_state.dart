part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;

  MapState({
    this.mapReady = false
  });

  MapState copyWith({
    bool? mapReady
  }) => MapState(
    mapReady: mapReady ?? this.mapReady
  );
}
