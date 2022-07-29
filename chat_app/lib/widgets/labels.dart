import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String label;
  final String title;
  const Labels({
    Key? key,
    this.route = 'register', 
    this.label = "Don't you have a account?", 
    this.title = 'Create New Account'
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Text(title, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold))
        )
      ],
    );
  }
}