import 'package:flutter/material.dart';
import 'package:custom_page_transitions/custom_page_transitions.dart';

import 'package:custom_transition_route/pages/page2.dart';

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
            PageTransitions(
              context: context,
              child: Page2(),
              animation: AnimationType.slideLeft,
              duration: Duration( milliseconds:  400 ),
              reverseDuration: Duration( milliseconds:  400),
              curve: Curves.decelerate,
              fullscreenDialog: true,
              replacement: false,
              settings: RouteSettings( arguments: 'argument' )
            );
          },
        )
      ),
    );
  }
}