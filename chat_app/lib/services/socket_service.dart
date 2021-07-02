import 'package:chat_app/global/environment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;
  
  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket? get socket => this._socket;
  Function get emit => this._socket!.emit;

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    String socketUrl = Environment.socketUrl;

    this._socket = IO.io(
      socketUrl,
      IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .enableAutoConnect()
        .enableForceNew()
        .setExtraHeaders({
          'x-token': token
        })
        .build()
    );

    // Status Online
    this._socket!.onConnect((_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

   // Status Offline
    this._socket!.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    this._socket!.disconnect();
  }
}