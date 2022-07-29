import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  
  const Logo({
    Key? key,
    this.title = 'Messenger'
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      width: 170,
      child: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/tag-logo.png'),
            const SizedBox(height: 20.0),
            Text(title, style: const TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}
