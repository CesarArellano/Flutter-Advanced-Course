import 'dart:async';

import 'package:cubit_state_app/models/user.dart';

class UserService {
  User? _user;
  

  final StreamController<User> _userStreamController = StreamController<User>.broadcast();

  Stream<User> get userStream => _userStreamController.stream;

  User? get user => _user;

  bool get isExistUser => ( _user != null );
  
  void loadUser(User newUser) {
    _user = newUser;
    _userStreamController.add(newUser);
  }

  void changeAge(int age) {
    _user?.age = age;
    _userStreamController.add( _user ?? User(name: 'César Arellano', age: age, professions: ['Mobile Developer']));
  }

  void dispose() {
    _userStreamController.close();
  }
}

final userService = UserService();