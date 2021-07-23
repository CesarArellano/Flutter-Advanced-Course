import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchDestinationsResult {
  final bool cancel;
  final bool? manually;
  final LatLng? position;
  final String? destinationName;
  final String? description;

  SearchDestinationsResult({
    required this.cancel, 
    this.manually, 
    this.position, 
    this.destinationName,
    this.description
  });

  
}