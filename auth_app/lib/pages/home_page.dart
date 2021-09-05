import 'package:flutter/material.dart';
import 'package:auth_app/services/google_signin_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('AuthApp Google - Apple'),
        actions: [
          IconButton(
            onPressed: () {
              GoogleSignInService.signOut();
            },
            icon: Icon( FontAwesomeIcons.doorOpen ),
            splashRadius: 26,
          ),  
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                splashColor: Colors.transparent,
                minWidth: double.infinity,
                height: 40,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon( FontAwesomeIcons.google, color: Colors.white ),
                    SizedBox(width: 8),
                    Text('Sign in with Google', style: TextStyle(color: Colors.white, fontSize: 17)),
                  ],
                ),
                onPressed: () {
                  GoogleSignInService.signInWithGoogle();
                },
              )
            ],
          ),
        ),
      )
    );
  }
}