import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../global/environment.dart';
import 'auth_service.dart';

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  io.Socket? _socket;
  
  ServerStatus get serverStatus => _serverStatus;

  io.Socket? get socket => _socket;
  Function get emit => _socket!.emit;

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    String socketUrl = Environment.socketUrl;

    _socket = io.io(
      socketUrl,
      io.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .enableAutoConnect()
        .enableForceNew()
        .setExtraHeaders({
          'x-token': token
        })
        .build()
    );

    // Status Online
    _socket!.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

   // Status Offline
    _socket!.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket!.disconnect();
  }
}