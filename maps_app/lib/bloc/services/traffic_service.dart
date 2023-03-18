import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/helpers/debouncer.dart';
import 'package:maps_app/models/reverse_query_response.dart';
import 'package:maps_app/models/traffic_response.dart';

class TrafficService {
  TrafficService._privateConstrutor();

  static final TrafficService _instance = TrafficService._privateConstrutor();
  
  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final debouncer = Debouncer<String>(duration: const Duration(milliseconds: 400 ));
  
  final StreamController _suggestionsStreamController = StreamController.broadcast();
  Stream get suggestionsStream => _suggestionsStreamController.stream;


  final _apiKey = 'pk.eyJ1IjoicmF5d2F5ZGF5IiwiYSI6ImNrcmZtZmk3ZDB3a2QycGxqMWJoZHJ3N3oifQ.i7a_5fZjpsDEuZvc-pivgQ';
  final baseUrl = 'https://api.mapbox.com';

  Future<DrivingResponse> getStartAndFinalCoords(LatLng origin, LatLng destination ) async {
    
    if( destination.latitude == 0 || destination.longitude == 0 ) {
      destination = origin;
    }
    
    final coordString = '${ origin.longitude },${ origin.latitude };${ destination.longitude },${ destination.latitude }';
    final url = '$baseUrl /directions/v5/mapbox/driving/$coordString';

    final resp = await _dio.get(url, queryParameters:  {
      'alternatives': true,
      'geometries': 'polyline6',
      'steps': false,
      'access_token': _apiKey,
      'language': 'es',
    });
    
    final data = DrivingResponse.fromJson(resp.data);
    
    return data;

  }

  Future getResultsByQuery(String query, LatLng proximity) async {
    final url = '$baseUrl /geocoding/v5/mapbox.places/$query.json';

    final resp = await _dio.get(url, queryParameters: {
      'access_token': _apiKey,
      'autocomplete': true,
      'proximity': '${ proximity.longitude },${ proximity.latitude }',
      'language': 'es',
    });

    final data = jsonDecode(resp.data);
    return data;
  }

  
  void getSuggestionsByQuery( String query, LatLng proximity ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final results = await getResultsByQuery(value, proximity);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 201)).then((_) => timer.cancel()); 

  }

  Future<ReverseQueryResponse> getCoordsInfo( LatLng destinationCoords ) async {
    final url = '$baseUrl/geocoding/v5/mapbox.places/${ destinationCoords.longitude },${ destinationCoords.latitude }.json';

    final resp = await _dio.get(url, queryParameters: {
      'access_token': _apiKey,
      'language': 'es',
    });

    final data = reverseQueryResponseFromJson(resp.data);

    return data;
  }
}