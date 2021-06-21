import 'dart:io';

class Environment {
  static String apiUrl = (Platform.isAndroid) ? 'http://192.168.31.161:3000/api' : 'http://localhost:3000/api';
  static String socketUrl = (Platform.isAndroid) ? 'http://192.168.31.161:3000' : 'http://localhost:3000';
}