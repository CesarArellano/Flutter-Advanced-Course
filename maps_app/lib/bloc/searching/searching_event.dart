part of 'searching_bloc.dart';

@immutable
abstract class SearchingEvent {}

class OnActivateManualMarker extends SearchingEvent {}

class OnDeactivateManualMarker extends SearchingEvent {}

class OnAddHistory extends SearchingEvent {
  final SearchDestinationsResult queryResult;

  OnAddHistory(this.queryResult);
}