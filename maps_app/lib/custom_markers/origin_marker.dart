part of 'custom_markers.dart';

class OriginMarkerPainter extends CustomPainter {

  final int minutes;
  
  OriginMarkerPainter(this.minutes);

  @override
  void paint(Canvas canvas, Size size) {
    const double blackCircleRadius = 20;
    const double whiteCircleRadius = 7;

    Paint paint = Paint()
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

    // Shadow
    final Path path = Path();
    path.moveTo( 40, 20);
    path.lineTo( size.width - 10, 20 );
    path.lineTo( size.width - 10, 100 );
    path.lineTo( 40, 100 );
    canvas.drawShadow(path, Colors.black87, 10, false);

    // White box
    final boxWhite = Rect.fromLTWH(40, 20, size.width - 55, 80);
    canvas.drawRect(boxWhite, paint);

    // Black box
    paint.color = Colors.black87;
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, paint);

    // Draw texts
    TextSpan textSpan = TextSpan(
      text: '$minutes',
      style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400 ),
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(canvas, const Offset(40, 35));

    // My location
    textSpan = const TextSpan(
      text: 'Min',
      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 ),
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(canvas, const Offset(40, 67));

    // My location

    textSpan = const TextSpan(
      text: 'My location',
      style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w400 ),
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: size.width - 130
    );

    textPainter.paint(canvas, const Offset(130, 45));

  }

  @override
  bool shouldRepaint(OriginMarkerPainter oldDelegate) => true;

}