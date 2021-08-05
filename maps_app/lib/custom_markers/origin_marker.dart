import 'package:flutter/material.dart';

class OriginMarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double blackCircleRadius = 20;
    final double whiteCircleRadius = 7;

    Paint paint = new Paint()
      ..color = Colors.black;

    // Draw black circle
    canvas.drawCircle(
      Offset( blackCircleRadius, size.height - blackCircleRadius), 
      blackCircleRadius, 
      paint
    );

    // Draw white circle
    paint.color = Colors.white;

    canvas.drawCircle(
      Offset( blackCircleRadius, size.height - blackCircleRadius), 
      whiteCircleRadius, 
      paint
    );
    
  }

  @override
  bool shouldRepaint(OriginMarkerPainter oldDelegate) => true;

}