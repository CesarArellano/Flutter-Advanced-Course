part of 'searching_bloc.dart';

@immutable
abstract class SearchingEvent {}

class OnActivateManualMarker extends SearchingEvent {}

class OnDeactivateManualMarker extends SearchingEvent {}