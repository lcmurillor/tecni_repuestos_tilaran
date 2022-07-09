// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/theme/main_theme.dart';

class CardLogin extends StatelessWidget {
  const CardLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 190, horizontal: 30),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: 342,
                height: 400,
                child: Text('Iniciar Sesión',
                    style: GoogleFonts.roboto(
                      fontSize: 44,
                      fontWeight: FontWeight.w600,
                    )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [MainTheme.cardShadow],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
