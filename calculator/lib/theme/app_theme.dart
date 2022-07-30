
import 'package:flutter/material.dart';

class AppTheme {

  static final darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
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