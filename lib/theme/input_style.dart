import 'package:flutter/material.dart';

class InputStyle {
  static InputDecoration mainInput({
    required String hintText,
    required IconData icon,
    IconData? suffixIcon,
  }) => InputDecoration(
    labelText: hintText,
    prefixIcon: Icon(icon),
    suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
  );
}
