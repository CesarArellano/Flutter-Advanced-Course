part of 'my_location_bloc.dart';

@immutable
abstract class MyLocationEvent {}

class OnLocationChanged extends MyLocationEvent {
  final LatLng location;
  
  OnLocationChanged(this.location);
}