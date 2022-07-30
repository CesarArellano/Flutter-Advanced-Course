
import 'package:flutter/material.dart';

class AppTheme {

  static final lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      onSurface: Colors.white
    ),
  );
}