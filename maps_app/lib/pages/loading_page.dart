import 'package:flutter/material.dart';

import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/gps_access_page.dart';
// import 'package:maps_app/pages/map_page.dart';

class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: Image.asset('assets/images/location.gif', width: 300)
          );
        }
      ),
    );
  }

  Future checkGpsAndLocation(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1000));
    // Navigator.pushReplacement(context, navigateMapFadeIn(context, MapPage()));
    // Navigator.pushReplacement(context, navigateMapFadeIn(context, GpsAccessPage()));
  }
}