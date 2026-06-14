import 'package:flutter/material.dart';

class DarkAppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(centerTitle: true,),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
    ),
  );
}