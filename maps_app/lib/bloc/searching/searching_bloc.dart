import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'searching_event.dart';
part 'searching_state.dart';

class SearchingBloc extends Bloc<SearchingEvent, SearchingState> {
  SearchingBloc() : super(SearchingState());

  @override
  Stream<SearchingState> mapEventToState( SearchingEvent event ) async* {
    if( event is OnActivateManualMarker ) {
      yield state.copyWith( manualSelection: true );
    } else if (event is OnDeactivateManualMarker ) {
      yield state.copyWith( manualSelection: false );
    }
  }
}