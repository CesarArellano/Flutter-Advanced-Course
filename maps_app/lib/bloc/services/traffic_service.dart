import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/traffic_response.dart';

class TrafficService {
  TrafficService._privateConstrutor();

  static final TrafficService _instance = TrafficService._privateConstrutor();
  
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();

  Future<DrivingResponse> getStartAndFinalCoords(LatLng origin, LatLng destination ) async {
    if( destination.latitude == 0 || destination.longitude == 0 ) {
      destination = origin;
    }

    final apiKey = 'pk.eyJ1IjoicmF5d2F5ZGF5IiwiYSI6ImNrb2Q4bW9jZzJqaGIyb3MyNXQxMmxnYjAifQ.iClpR862aSTbYa8aDRwvpg';
    final coordString = '${ origin.longitude },${ origin.latitude };${ destination.longitude },${ destination.latitude }';
    final url = 'https://api.mapbox.com/directions/v5/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters:  {
      'alternatives': true,
      'geometries': 'polyline6',
      'steps': false,
      'access_token': apiKey,
      'language': 'es',
    });
    
    final data = DrivingResponse.fromJson(resp.data);
    
    return data;

  }
}