part of 'my_location_bloc.dart';

@immutable
class MyLocationState {
  final bool following;
  final bool existLocation;
  final LatLng? location;

  MyLocationState({ 
    this.following = true,
    this.existLocation = false,
    this.location
  });

  MyLocationState copyWith({
    bool? following,
    bool? existLocation,
    LatLng? location,
  }) => new MyLocationState(
    following    : following ?? this.following,
    existLocation: existLocation ?? this.existLocation,
    location     : location ?? this.location
  );
}