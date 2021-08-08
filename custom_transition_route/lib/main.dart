import 'package:flutter/material.dart';

import 'package:custom_transition_route/pages/page1.dart';
import 'package:custom_transition_route/pages/page2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Transition Route App',
      initialRoute: 'page1',
      routes:  {
        'page1': (_) => Page1(),
        'page2': (_) => Page2(),
      },
    );
  }
}