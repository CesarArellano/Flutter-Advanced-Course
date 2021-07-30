import 'dart:convert';

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
  final _apiKey = 'pk.eyJ1IjoicmF5d2F5ZGF5IiwiYSI6ImNrcmZtZmk3ZDB3a2QycGxqMWJoZHJ3N3oifQ.i7a_5fZjpsDEuZvc-pivgQ';
  final baseUrl = 'https://api.mapbox.com';

  Future<DrivingResponse> getStartAndFinalCoords(LatLng origin, LatLng destination ) async {
    
    if( destination.latitude == 0 || destination.longitude == 0 ) {
      destination = origin;
    }
    
    final coordString = '${ origin.longitude },${ origin.latitude };${ destination.longitude },${ destination.latitude }';
    final url = '${ this.baseUrl }/directions/v5/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters:  {
      'alternatives': true,
      'geometries': 'polyline6',
      'steps': false,
      'access_token': this._apiKey,
      'language': 'es',
    });
    
    final data = DrivingResponse.fromJson(resp.data);
    
    return data;

  }

  Future getResultsByQuery(String query, LatLng proximity) async {
    final url = '${ this.baseUrl }/geocoding/v5/mapbox.places/$query.json';

    final resp = await this._dio.get(url, queryParameters: {
      'access_token': this._apiKey,
      'autocomplete': true,
      'proximity': '${ proximity.longitude },${ proximity.latitude }',
      'language': 'es',
    });

    final data = jsonDecode(resp.data);
    return data;
  }
}