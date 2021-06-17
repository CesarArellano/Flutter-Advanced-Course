import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _Logo(),
            _Form(),
            _Labels(),
            _TermsAndConditions(),
          ],
        )
      )
    );
  }
}

class _TermsAndConditions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Text(
        'Términos y condiciones de uso', 
        style: TextStyle(fontWeight: FontWeight.w300)
      )
    );
  }
}

class _Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: 170,
      child: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/tag-logo.png'),
            SizedBox(height: 20.0),
            Text('Messenger', style: TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: <Widget> [
          CustomInput(),
          ElevatedButton(
            onPressed: () {},
            child: Text('Ingresar', style: TextStyle(fontSize: 16.0))
          )
        ]
      ),
    );
  }
}

class _Labels extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Don't you have a account?", style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          Text('Create New Account', style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold))
        ],
      )
    );
  }
}