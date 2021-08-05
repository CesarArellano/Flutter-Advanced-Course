import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TotalPayButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    return Container(
      width: width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total', style: textStyle),
              Text('250.55 USD', style: TextStyle(fontSize: 20))
            ],
          ),
          _BtnPay()
        ],
      )
    );
  }
}

class _BtnPay extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return true 
      ? buildCreditCardPay()
      : buildAppleAndGooglePay();
  }

  Widget buildAppleAndGooglePay() {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          FaIcon( 
            Platform.isAndroid
            ? FontAwesomeIcons.google 
            : FontAwesomeIcons.apple,
            color: Colors.white
          ),
          SizedBox(width: 10),
          Text('Pay', style: TextStyle(color: Colors.white, fontSize: 22)),
        ],
      ),
      onPressed: () {},
    );
  }

  Widget buildCreditCardPay() {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.creditCard, color: Colors.white ),
          SizedBox(width: 10),
          Text('Pay', style: TextStyle(color: Colors.white, fontSize: 22),),
        ],
      ),
      onPressed: () {},
    );
  }
}