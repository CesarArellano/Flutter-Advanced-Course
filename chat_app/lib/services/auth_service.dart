import 'dart:convert';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';

class AuthService with ChangeNotifier {

  User? user;
  bool _authenticating = false;

  bool get authenticating  => this._authenticating;

  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
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
      return true;
    } else {
      return false;
    }
    
  }
}