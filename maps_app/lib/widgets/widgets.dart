import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:animate_do/animate_do.dart';

import 'package:maps_app/bloc/map/map_bloc.dart';
import 'package:maps_app/bloc/my_location/my_location_bloc.dart';
import 'package:maps_app/bloc/searching/searching_bloc.dart';
import 'package:maps_app/bloc/services/traffic_service.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/search_destinations_result.dart';
import 'package:maps_app/search/search_destination.dart';

part 'btn_location.dart';
part 'btn_my_route.dart';
part 'btn_follow_location.dart';
part 'searchbar.dart';
part 'manual_marker.dart';