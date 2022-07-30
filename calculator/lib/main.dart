import 'package:flutter/material.dart';

import 'screens/calculator_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp( const MyApp() );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      home: CalculatorScreen(),
      theme: AppTheme.darkTheme
    );
  }
}