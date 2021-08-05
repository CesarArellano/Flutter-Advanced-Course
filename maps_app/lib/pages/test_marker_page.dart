import 'package:flutter/material.dart';
import 'package:maps_app/custom_markers/destination_marker.dart';

import 'package:maps_app/custom_markers/origin_marker.dart';

class TestMarkerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.green,
          child: CustomPaint(
            painter: DestinationMarkerPainter(
              'My house somewhere in the world, it is here, assadasd',
              25542
            ),
          ),
        )
      ),
    );
  }
}