import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/models/message_response.dart';
import 'package:chat_app/models/user_model.dart';


class ChatService with ChangeNotifier {

  User? userTo;

  Future<List<Message>> getChat(String userID) async {
    try {
      final resp = await http.get(Uri.parse('${ Environment.apiUrl }/messages/$userID'),
        headers: {
          'Content-Type': 'applications/json',
          'x-token': await AuthService.getToken()
        }
      );

      final messageResp = messageResponseFromJson(resp.body);
      return messageResp.messages ?? [];
      
    } catch (e) {
      return [];
    }
    
  }
}