import 'package:flutter/material.dart';


class CustomInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail_outline),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: 'Email'
        ),
      )
    );
  }
}