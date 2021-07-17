import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


part 'my_location_event.dart';
part 'my_location_state.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  MyLocationBloc() : super(MyLocationState());

  @override
  Stream<MyLocationState> mapEventToState( MyLocationEvent event ) async* {
    // TODO: implement mapEventToState
  }
}
