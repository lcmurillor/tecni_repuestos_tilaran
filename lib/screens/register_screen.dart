import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/screens/ui/input_decorations.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

import '../theme/app_theme.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
          body: Background(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 180),
            CardContainer(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Regístrate',
                      style: GoogleFonts.roboto(
                          fontSize: 45, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 15,
                  ),
                  _RegisterForm()
                ],
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 70),
                    child: Text(
                      '¿No tienes cuenta?',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      ' Regístrate ahora',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Color.fromRGBO(0, 152, 181, 1)),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      )),
    );
  }
}

class _RegisterForm extends StatelessWidget {
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
                directionIcon: 'assets/phone.svg'),
          ),
          SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Nombre', directionIcon: 'assets/person.svg'),
          ),
          SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Apellidos', directionIcon: 'assets/person.svg'),
          ),
          SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Teléfono', directionIcon: 'assets/phone.svg'),
          ),
          SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Fecha de nacimiento',
                directionIcon: 'assets/date.svg'),
          ),
          SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Contraseña', directionIcon: 'assets/phone.svg'),
          ),
          SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Confirmar contraseña',
                directionIcon: 'assets/phone.svg'),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 40),
                child: Checkbox(
                  activeColor: Color.fromRGBO(214, 39, 31, 1),
                  onChanged: (bool? value) {},
                  value: true,
                ),
              ),
              Text(
                'Términos y condicones',
                style: GoogleFonts.roboto(
                    color: Color.fromRGBO(0, 152, 181, 1),
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              disabledColor: Colors.grey,
              color: Color.fromRGBO(214, 39, 31, 1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                child: Text(
                  'Crear cuenta',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
              ),
              onPressed: () {}),
          SizedBox(height: 15),
          Text(
            '¿Olvidaste tu contraseña?',
            style: GoogleFonts.roboto(
                color: Color.fromRGBO(0, 152, 181, 1),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 14)
        ],
      ),
    );
  }
}
