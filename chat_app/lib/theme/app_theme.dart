
import 'package:flutter/material.dart';

class AppTheme {

  static final lightTheme = ThemeData.light().copyWith(
    splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      onSurface: Colors.white
    ),
  );
}