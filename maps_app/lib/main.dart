import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Blocs
import 'package:maps_app/bloc/map/map_bloc.dart';
import 'package:maps_app/bloc/my_location/my_location_bloc.dart';
import 'package:maps_app/bloc/searching/searching_bloc.dart';

// Pages
import 'package:maps_app/pages/gps_access_page.dart';
import 'package:maps_app/pages/loading_page.dart';
import 'package:maps_app/pages/map_page.dart';
import 'package:maps_app/pages/test_marker_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => MyLocationBloc() ),
        BlocProvider(create: ( _ ) => MapBloc() ),
        BlocProvider(create: ( _ ) => SearchingBloc() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maps App',
        initialRoute: 'test_marker',
        routes: {
          'loading': (_) => LoadingPage(),
          'gps_access': ( _ ) => GpsAccessPage(),
          'map': (_) => MapPage(),
          'test_marker': ( _ ) => TestMarkerPage(),
        }
      ),
    );
  }
}