import 'package:chat_app/widgets/blue_btn.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/logo.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/custom_input.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Logo(title: 'Sign Up'),
              _Form(),
              Labels(route: 'login', label: 'Do you already have a account?',title: 'Sign In'),
              _TermsAndConditions(),
            ],
          ),
        )
      )
    );
  }
}

class _TermsAndConditions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 60),
          child: Text(
            'Términos y condiciones de uso', 
            style: TextStyle(fontWeight: FontWeight.w300)
          ),
        ),
        SizedBox(height: 40.0)
      ],
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: <Widget> [
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Name',
            keyboardType: TextInputType.name, 
            textController: nameController,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress, 
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outlined,
            placeholder: 'Password',
            keyboardType: TextInputType.text, 
            textController: passController,
            isPassword: true,
          ),
          BlueBtn(
            text: 'Create',
            onPressed: () {
              print(emailController.text);
            },
          )
        ]
      ),
    );
  }
}

