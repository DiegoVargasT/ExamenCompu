import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Colors.blue;

  static final ThemeData myTheme = ThemeData(
    primaryColor: primary,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      color: primary,
    ),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: primary)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: primary)
  );
}