import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/google_signin_service.dart';
import 'view_profile_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('AuthApp Google - Apple'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: MaterialButton(
            splashColor: Colors.transparent,
            minWidth: double.infinity,
            height: 40,
            color: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon( FontAwesomeIcons.google, color: Colors.white ),
                SizedBox(width: 8),
                Text('Sign in with Google', style: TextStyle(color: Colors.white, fontSize: 17)),
              ],
            ),
            onPressed: () => _submit(context)
          ),
        ),
      )
    );
  }

  Future<void> _submit(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    final account = await GoogleSignInService.signInWithGoogle();
    
    if( account == null ) {
      if ( !context.mounted ) return;
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.hideCurrentSnackBar();
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error al autenticar usuario.'),
        )
      );
      return;
    }

    if ( !context.mounted ) return;
    Navigator.push(
      context, 
      CupertinoPageRoute(
        builder: (_) => const ViewProfileScreen(),
        settings: RouteSettings(arguments: account)
      )
    );
  }
}