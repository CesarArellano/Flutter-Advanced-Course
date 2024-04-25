
import 'package:flutter/material.dart';

class AppTheme {

  static const orangeButtonColor = Color(0xfff28e00 );
  static const darkGrayButtonColor = Color(0xFF9f9f9f);
  
  static final darkTheme = ThemeData.dark().copyWith(
    splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.green,
      onSurface: Colors.white
    ),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.black) )
    )
  );
}