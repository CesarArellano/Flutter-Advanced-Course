part of 'helpers.dart';

Future<BitmapDescriptor> getMarkerOriginIcon( int seconds ) async {
  
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);

  final minutes = (seconds / 60).floor();
  final originMarker = OriginMarkerPainter(minutes);
  originMarker.paint(canvas, size);
  
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

}

Future<BitmapDescriptor> getMarkerDestinationIcon( String description, double meters ) async {
  
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);
  
  final originMarker = DestinationMarkerPainter(description, meters);
  originMarker.paint(canvas, size);
  
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  
}