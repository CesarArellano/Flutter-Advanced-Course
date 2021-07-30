part of 'searching_bloc.dart';

@immutable
class SearchingState {
  final bool manualSelection;
  final List<SearchDestinationsResult> history;

  SearchingState({
    this.history = const [],
    this.manualSelection = false,
  });

  SearchingState copyWith({
    bool? manualSelection,
    List<SearchDestinationsResult>? history
  }) => new SearchingState(
    manualSelection: manualSelection ?? this.manualSelection,
    history: history ?? this.history
  );
  
}