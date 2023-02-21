import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_states_app/bloc/user/user_bloc.dart';

import '../models/user.dart';

class DetailScreen extends StatelessWidget {
  
  const DetailScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UserBloc, UserState>(
          builder: (BuildContext context, UserState state) {
            final name = state.user?.name ?? 'Detail Page';
            return Text(name);
          }
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DetailButton(
              text: 'Set user',
              onPressed: () {
                final newUser = User(
                  name: 'César Arellano',
                  age: 23,
                  professions: ['Flutter Developer', 'React Developer']
                );
                
                userBloc.add(ActivateUser( newUser ));
              },
            ),
            _DetailButton(
              text: 'Set age',
              onPressed: () {
                userBloc.add(ChangeUserAge(32));
              },
            ),
            _DetailButton(
              text: 'Add profession',
              onPressed: () {
                userBloc.add(AddUserProffesion('New Profession'));
              },
            ),
            _DetailButton(
              text: 'Remove user',
              onPressed: () {
                userBloc.add(RemoveUser());
              },
            ),
          ],
        )
      ),
    );
  }
}

class _DetailButton extends StatelessWidget {
  const _DetailButton({
    Key? key,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.black,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}