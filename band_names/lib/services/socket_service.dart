import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
  
  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    String urlSocket = 'http://192.168.31.161:3000';

    this._socket = IO.io(
      urlSocket,
      IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .enableAutoConnect()
        .build()
    );

    // Status Online
    this._socket.onConnect((_) {
      this._serverStatus = ServerStatus.Online;
      print('Connected by socket');
      notifyListeners();
    });

   // Status Offline
    this._socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      print('Disconnected');
      notifyListeners();
    });
  }
}