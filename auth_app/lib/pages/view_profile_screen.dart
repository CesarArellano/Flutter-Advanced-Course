import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/user_response.dart';
import '../services/google_signin_service.dart';


class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final userResponse = ModalRoute.of(context)?.settings.arguments as UserResponse;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('View Profile'),
        
        actions: [
          IconButton(
            onPressed: () => _signOut(context),
            icon: const Icon( FontAwesomeIcons.doorOpen ),
            splashRadius: 25,
          ),  
          const SizedBox(width: 10),
        ],
        leading: IconButton( 
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _signOut(context),
          splashRadius: 25,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                userResponse.googleUser!.picture!,
              ),
            ),
            const SizedBox(height: 20),
            Text('Username: ${ userResponse.googleUser?.name }'),
            Text('Email: ${ userResponse.googleUser?.email }'),
          ],
        )
      ),
    );
  }

  void _signOut(BuildContext context) {
    GoogleSignInService.signOut();
    Navigator.pop(context);
  }
}