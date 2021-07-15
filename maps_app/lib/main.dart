import 'package:flutter/material.dart';

import 'package:maps_app/pages/gps_access_page.dart';
import 'package:maps_app/pages/loading_page.dart';
import 'package:maps_app/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      initialRoute: 'gps_access',
      routes: {
        'loading': (_) => LoadingPage(),
        'gps_access': ( _ ) => GpsAccessPage(),
        'map': (_) => MapPage()
      }
    );
  }
}