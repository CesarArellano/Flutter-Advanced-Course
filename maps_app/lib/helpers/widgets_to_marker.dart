part of 'helpers.dart';

Future<BitmapDescriptor> getMarkerOriginIcon( int seconds ) async {
  
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(350, 150);

  final minutes = (seconds / 60).floor();
  final originMarker = new OriginMarkerPainter(minutes);
  originMarker.paint(canvas, size);
  
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

}

Future<BitmapDescriptor> getMarkerDestinationIcon( String description, double meters ) async {
  
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(350, 150);
  
  final originMarker = new DestinationMarkerPainter(description, meters);
  originMarker.paint(canvas, size);
  
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  
}