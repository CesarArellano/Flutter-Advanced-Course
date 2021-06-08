import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  
  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    IO.Socket socket = IO.io('http://192.168.31.161:3000/', {
      'transports': ['websocket'],
      'autoConnect': true
    });
    
    socket.onConnect((_) => print('Connect'));

    socket.onDisconnect((_) => print('Disconnect'));

  }
}