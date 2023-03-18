part of 'searching_bloc.dart';

@immutable
class SearchingState {
  final bool manualSelection;
  final List<SearchDestinationsResult> history;

  const SearchingState({
    this.history = const [],
    this.manualSelection = false,
  });

  SearchingState copyWith({
    bool? manualSelection,
    List<SearchDestinationsResult>? history
  }) => SearchingState(
    manualSelection: manualSelection ?? this.manualSelection,
    history: history ?? this.history
  );
  
}