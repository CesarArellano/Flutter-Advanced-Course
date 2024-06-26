
import 'package:flutter/material.dart';

class AppTheme {

  static final lightTheme = ThemeData.light().copyWith(
    splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
    colorScheme: const ColorScheme.light(
      primary: Colors.green,
      onSurface: Colors.white
    ),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.black) )
    )
  );
}