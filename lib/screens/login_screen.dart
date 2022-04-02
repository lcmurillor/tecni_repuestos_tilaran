// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

import '../theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        body: Stack(
      children: [Background(), CardLogin()],
    ));
  }
}

class CardLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 160, horizontal: 30),
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
    );
  }
}
