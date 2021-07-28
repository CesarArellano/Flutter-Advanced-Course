import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  TrafficService._privateConstrutor();

  static final TrafficService _instance = TrafficService._privateConstrutor();
  
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();

  Future getStartAndFinalCoords(LatLng origin, LatLng destination ) async {
    print(origin);
    print(destination);
  }
}