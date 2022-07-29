import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/login_response.dart';
import '../models/user_model.dart';

class AuthService with ChangeNotifier {

  User? user;
  bool _authenticating = false;

  bool get authenticating  => _authenticating;
  final _storage = const FlutterSecureStorage();

  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token ?? '';
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;

    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post(
      Uri.parse('${Environment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    authenticating = false;

    if(resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }

  }

  Future register(String name, String email, String password) async {
    authenticating = true;

    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Environment.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    log(resp.body);
    authenticating = false;

    if(resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    
    final resp = await http.get(
      Uri.parse('${Environment.apiUrl}/login/renew'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token ?? ''
      }
    );

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      _saveToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}