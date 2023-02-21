import 'package:cubit_state_app/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(): super(UserInitialState());

  void setUser(User newUser) {
    emit(ActiveUser(user: newUser));
  }

  void changeUserAge(int newAge) {
    if( state is ActiveUser) {
      final oldUser = state as ActiveUser;
      emit(ActiveUser(user: oldUser.user.copyWith(age: newAge) ));
    }
  }

  void addUserProfession(String newProfession) {
    if( state is ActiveUser) {
      final oldUser = state as ActiveUser;
      final newProfessions = [ ...oldUser.user.professions, newProfession ];
      emit(ActiveUser(user: oldUser.user.copyWith(professions:  newProfessions) ));
    }
  }

  void deleteUser() {
    emit(UserInitialState());
  }
}