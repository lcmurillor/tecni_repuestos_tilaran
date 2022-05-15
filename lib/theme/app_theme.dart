import 'package:flutter/material.dart';

class MainTheme {
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.25),
    offset: const Offset(0, 0),
    blurRadius: 10,
  );
  static final ThemeData lightTheme = ThemeData.light().copyWith();
  static final ThemeData darkTheme = ThemeData.dark().copyWith();
}
