import 'package:flutter/material.dart';

class DynamicTheme {
  static const _seedColor = Color(0XFFF6F1C4);

  static ThemeData lightTheme(ColorScheme? lightColorScheme) {
    ColorScheme defaultLightColorScheme = lightColorScheme ?? ColorScheme.fromSeed(seedColor: _seedColor, brightness: Brightness.light);
    return ThemeData(
      colorScheme: defaultLightColorScheme,
      useMaterial3: true,
      fontFamily: "PretendardVariation",
    );  
  }

  static ThemeData darkTheme(ColorScheme? darkColorScheme) {
    ColorScheme defaultDarkColorScheme = darkColorScheme ?? ColorScheme.fromSeed(seedColor: _seedColor, brightness: Brightness.dark);
    return ThemeData(
      colorScheme: defaultDarkColorScheme,
      useMaterial3: true,
      fontFamily: "PretendardVariation",
    );
  }
}