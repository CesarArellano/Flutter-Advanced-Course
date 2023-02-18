import 'package:new_states_app/models/user.dart';

class UserService {
  User? _user;
  
  User? get user => _user;

  bool get isExistUser => ( _user != null );
  
  void loadUser(User newUser) {
    _user = newUser;
  }
}

final userService = UserService();