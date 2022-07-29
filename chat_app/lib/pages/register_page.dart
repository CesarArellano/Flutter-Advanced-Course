import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/show_alert.dart';
import '../services/auth_service.dart';
import '../services/socket_service.dart';
import '../widgets/blue_btn.dart';
import '../widgets/custom_input.dart';
import '../widgets/labels.dart';
import '../widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              const Logo(title: 'Sign Up'),
              _Form(),
              const Labels(route: 'login', label: 'Do you already have a account?',title: 'Sign In'),
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
          margin: const EdgeInsets.only(top: 60),
          child: const Text(
            'Términos y condiciones de uso', 
            style: TextStyle(fontWeight: FontWeight.w300)
          ),
        ),
        const SizedBox(height: 40.0)
      ],
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50.0),
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
            onPressed: (authService.authenticating)
            ? null
            : () async {
              socketService.connect();
              FocusScope.of(context).unfocus();
              final registerOk = await authService.register(nameController.text, emailController.text, passController.text);
              
              if( !mounted ) return;
              
              if (registerOk == true) {
                Navigator.pushReplacementNamed(context, 'users');
              } else {
                showAlert(context, 'Bad register', registerOk);
              }
            },
          )
        ]
      ),
    );
  }
}

