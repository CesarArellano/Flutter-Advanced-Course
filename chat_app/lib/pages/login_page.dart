import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/show_alert.dart';
import '../services/auth_service.dart';
import '../services/socket_service.dart';
import '../widgets/blue_btn.dart';
import '../widgets/custom_input.dart';
import '../widgets/labels.dart';
import '../widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              const Logo(),
              _Form(),
              const Labels(),
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
            icon: Icons.mail_outline,
            placeholder: 'Correo',
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
            onPressed: authService.authenticating 
            ? null
            : () async {
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(emailController.text, passController.text);
              
              if( !context.mounted ) return;
              
              if (loginOk) {
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'users');
              } else {
                showAlert(context, 'Bad login', 'Check your credentials');
              }
            },
          )
        ]
      ),
    );
  }
}

