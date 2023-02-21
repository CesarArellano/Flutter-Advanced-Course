import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_state_app/bloc/user/user_cubit.dart';

import '../models/user.dart';

class DetailScreen extends StatelessWidget {
  
  const DetailScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = context.read<UserCubit>();

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UserCubit, UserState>(
          builder: (BuildContext context, UserState state) {
            if( state is ActiveUser ) {
              return Text(state.user.name);
            }
            
            return const Text('Detail Page');
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
                
                userCubit.setUser(newUser);
              },
            ),
            _DetailButton(
              text: 'Set age',
              onPressed: () {
                userCubit.changeUserAge(32);
              },
            ),
            _DetailButton(
              text: 'Add profession',
              onPressed: () {
                userCubit.addUserProfession('New Profession');
              },
            ),
            _DetailButton(
              text: 'Remove user',
              onPressed: () {
                userCubit.deleteUser();
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