import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;

import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/gps_access_page.dart';
import 'package:maps_app/pages/map_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData) {
            return Center( child: Text(snapshot.data, style: TextStyle(fontSize: 18)) );
          } else {
            return Center(
              child: Image.asset('assets/images/location.gif', width: 300)
            );
          }
        }
      ),
    );
  }

  Future<String> checkGpsAndLocation(BuildContext context) async {
    final gpsPermission = await Permission.location.isGranted;
    final gpsActive = await Geolocator.Geolocator.isLocationServiceEnabled();
    
    if( gpsPermission && gpsActive ) {
      Navigator.pushReplacement(context, navigateMapFadeIn(context, MapPage()));
      return '';
    } else if( !gpsPermission ) {
      Navigator.pushReplacement(context, navigateMapFadeIn(context, GpsAccessPage()));
      return 'It is necessary GPS permission';
    } else {
      return 'Activate GPS';
    }
  }
}