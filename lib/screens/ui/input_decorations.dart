import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InputDecorations {
  static InputDecoration loginScreen({
    required String hintText,
    required String directionIcon,
  }) {
    return InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.9, horizontal: 15),
        prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              directionIcon,
              fit: BoxFit.contain,
            )),
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[500]),
        fillColor: const Color.fromRGBO(143, 143, 143, 220),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)));
  }
}
