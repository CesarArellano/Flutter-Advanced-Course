import 'package:custom_transition_route/pages/page2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Page1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: MaterialButton(
          child: Text('Go to page 2'),
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          onPressed: () {
            Navigator.push(context, CupertinoPageRoute(builder: ( _ ) => Page2() ));
          },
        )
      ),
    );
  }
}