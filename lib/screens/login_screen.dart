// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/screens/ui/input_decorations.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

import '../theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
          body: Background(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 220),
            CardContainer(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Iniciar Sesion',
                      style: GoogleFonts.roboto(
                          fontSize: 45, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 30,
                  ),
                  _LoginForm()
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 70),
                    child: Text(
                      '¿No tienes una cuenta?',
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      ' Regístrate ahora',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 152, 181, 1)),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Correo Electrónico',
                directionIcon: 'assets/person.svg'),
          ),
          SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Contraseña', directionIcon: 'assets/search.svg'),
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              disabledColor: Colors.grey,
              color: Color.fromRGBO(214, 39, 31, 1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  'Iniciar sesión',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
              ),
              onPressed: () {}),
          SizedBox(height: 20),
          Text(
            '¿Olvidaste tu contraseña?',
            style: GoogleFonts.roboto(
                color: Color.fromRGBO(0, 152, 181, 1),
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
