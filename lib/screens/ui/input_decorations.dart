import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InputDecorations {
  static InputDecoration loginScreen({
    required String hintText,
    required String directionIcon,
  }) {
    return InputDecoration(
        prefixIcon: Padding(
            padding: const EdgeInsets.all(7),
            child: SvgPicture.asset(
              directionIcon,
              fit: BoxFit.contain,
            )),
        hintText: hintText,
        hintStyle:
            GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600),
        fillColor: Color.fromRGBO(143, 143, 143, 207),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)));
  }
}
