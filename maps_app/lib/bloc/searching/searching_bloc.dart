import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/models/search_destinations_result.dart';
import 'package:meta/meta.dart';

part 'searching_event.dart';
part 'searching_state.dart';

class SearchingBloc extends Bloc<SearchingEvent, SearchingState> {
  
  SearchingBloc() : super(const SearchingState());

  @override
  Stream<SearchingState> mapEventToState( SearchingEvent event ) async* {
    if( event is OnActivateManualMarker ) {
      yield state.copyWith( manualSelection: true );
    } else if ( event is OnDeactivateManualMarker ) {
      yield state.copyWith( manualSelection: false );
    } else if ( event is OnAddHistory ) {
      
      final exists = state.history.where(
        (result) => result.destinationName == event.queryResult.destinationName
      ).length;

      if (exists == 0) {
        final newHistory = [ ...state.history, event.queryResult ];
        yield state.copyWith( history: newHistory );
      }
    }
  }
  
}
