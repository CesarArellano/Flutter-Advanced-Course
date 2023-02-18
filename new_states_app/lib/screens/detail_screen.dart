import 'package:flutter/material.dart';
import 'package:new_states_app/services/user_service.dart';

import '../models/user.dart';

class DetailScreen extends StatelessWidget {
  
  const DetailScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<User>(
          stream: userService.userStream,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            final name = snapshot.data?.name ?? 'Detail Page';
            return Text(name);
          }
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DetailButton(
              text: 'Set User',
              onPressed: () {
                userService.loadUser(User(
                  age: 22,
                  name: 'César Arellano',
                  professions: ['Mobile Developer', 'Web Developer']
                ));
              },
            ),
            _DetailButton(
              text: 'Set Age',
              onPressed: () {
                userService.changeAge(23);
              },
            ),
            _DetailButton(
              text: 'Add profession',
              onPressed: () {

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