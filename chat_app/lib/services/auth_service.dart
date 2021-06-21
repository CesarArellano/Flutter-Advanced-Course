import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/global/environment.dart';

class AuthService with ChangeNotifier {

  User? user;
  bool _authenticating = false;

  bool get authenticating  => this._authenticating;
  final _storage = new FlutterSecureStorage();

  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token ?? '';
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future login(String email, String password) async {
    this.authenticating = true;

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

    this.authenticating = false;

    if(resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      this._saveToken(loginResponse.token);
      return true;
    } else {
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