import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String label;
  final String title;
  Labels({
    this.route = 'register', 
    this.label = "Don't you have a account?", 
    this.title = 'Create New Account'
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(this.label, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.route);
            },
            child: Text(this.title, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold))
          )
        ],
      )
    );
  }
}