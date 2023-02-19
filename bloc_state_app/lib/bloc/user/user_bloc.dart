import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:new_states_app/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(): super(const UserInitialState());

  
  
}