import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:new_states_app/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(): super(const UserInitialState()) {
    
    on<ActivateUser>((event, emit) => emit( UserSetState(event.user) ));

    on<ChangeUserAge>((event, emit) {
      if( !state.existUser ) return;
      emit(UserSetState(state.user?.copyWith(
        age: event.age
      )));
    });

    on<AddUserProffesion>((event, emit) {
      if( !state.existUser ) return;
      emit(UserSetState(state.user?.copyWith(
        professions: [ ...state.user!.professions, event.newProfession]
      )));
    });

    on<RemoveUser>((event, emit) => emit( const UserInitialState() ));

  }
}