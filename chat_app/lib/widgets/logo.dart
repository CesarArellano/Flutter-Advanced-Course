import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  
  Logo({ this.title = 'Messenger' });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: 170,
      child: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/tag-logo.png'),
            SizedBox(height: 20.0),
            Text(this.title, style: TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}
