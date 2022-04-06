import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tecni_repuestos/screens/ui/input_decorations.dart';

class TextFormFieldMethod {
  static TextFormField registerScreen({
    required TextInputType keyboardType,
    required bool decision,
    required String directionIcon,
    required String hintText,
  }) {
    return TextFormField(
      autocorrect: false,
      obscureText: decision,
      keyboardType: keyboardType,
      decoration: InputDecorations.loginScreen(
        hintText: hintText,
        directionIcon: directionIcon,
      ),
    );
  }
}
