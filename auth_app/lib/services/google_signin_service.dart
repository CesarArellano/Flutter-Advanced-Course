import 'dart:convert';

import 'package:auth_app/models/user_response.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<UserResponse?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      final googleKey = await account!.authentication;
      final signInWithGoogleEndpoint = Uri.parse('https://apple-google-sign-in-rwd.herokuapp.com/google');
      
      final params = {
        'token': googleKey.idToken
      };

      final resp = await http.post(
        signInWithGoogleEndpoint,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(params)
      );

      final Map<String, dynamic> decodedData = jsonDecode(resp.body);

      if( decodedData.containsKey('ok') ) {
        final decode = UserResponse.fromJson(decodedData);
        return decode.ok! ? decode : null;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
  
  static Future signOut() async {
    await _googleSignIn.signOut();
  }
}