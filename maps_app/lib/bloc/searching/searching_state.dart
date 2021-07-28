part of 'searching_bloc.dart';

@immutable
class SearchingState {
  final bool manualSelection;

  SearchingState({
    this.manualSelection = false,
  });

  SearchingState copyWith({
    bool? manualSelection
  }) => new SearchingState(
    manualSelection: manualSelection ?? this.manualSelection
  );
  
}