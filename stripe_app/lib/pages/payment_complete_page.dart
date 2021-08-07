import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentCompletePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Completed'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon( FontAwesomeIcons.star, color: Colors.white, size: 100),
            SizedBox(height: 20),
            Text('Payment made correctly!', style: TextStyle(color: Colors.white, fontSize: 22)),
            
          ],
        )
      ),
    );
  }
}