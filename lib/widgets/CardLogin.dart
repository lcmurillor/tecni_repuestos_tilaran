// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ignore: use_key_in_widget_constructors
class CardLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 190, horizontal: 30),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: 342,
                height: 400,
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text('Iniciar Sesión',
                      style: GoogleFonts.roboto(
                        fontSize: 44,
                        fontWeight: FontWeight.w600,
                      )),
                ),
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
