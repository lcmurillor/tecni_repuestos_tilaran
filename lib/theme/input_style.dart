import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class InputStyle {
  static InputDecoration mainInput({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.9, horizontal: 15),
        prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorStyle.mainRed),
              child: Icon(
                icon,
                size: 18,
                color: Colors.white,
              ),
            )),
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[500]),
        fillColor: const Color.fromRGBO(143, 143, 143, 220),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)));
  }
}
