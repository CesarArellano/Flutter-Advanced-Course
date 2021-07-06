import 'package:flutter/material.dart';
import 'package:states_app/pages/pageOne.dart';
import 'package:states_app/pages/pageTwo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'pageOne',
      routes: {
        'pageOne': ( _ ) => PageOne(),
        'pageTwo': ( _ ) => PageTwo()
      }
    );
  }
}