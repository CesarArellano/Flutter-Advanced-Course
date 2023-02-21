part of 'user_cubit.dart';

@immutable
abstract class UserState {
}

class UserInitialState extends UserState {
  final bool existUser = false;
}

class ActiveUser extends UserState {
  final bool existUser = true;
  final User user;

  ActiveUser({ 
    required this.user
  });
}
