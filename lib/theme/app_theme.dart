import 'package:flutter/material.dart';

class MainTheme {
  static Color mainRed = const Color.fromRGBO(214, 39, 31, 1);
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.25),
    offset: const Offset(0, 10),
    blurRadius: 10,
  );
  static final ThemeData lightTheme = ThemeData.light().copyWith();
}
