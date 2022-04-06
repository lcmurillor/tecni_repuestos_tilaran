import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/screens/ui/input_decorations.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Background(
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 180),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Iniciar Sesion',
                      style: GoogleFonts.roboto(
                          fontSize: 45, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 30,
                  ),
                  _LoginForm()
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 70),
                    child: Text(
                      '¿No tienes cuenta?',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      ' Regístrate ahora',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: const Color.fromRGBO(0, 152, 181, 1)),
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
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Contraseña', directionIcon: 'assets/search.svg'),
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              disabledColor: Colors.grey,
              color: const Color.fromRGBO(214, 39, 31, 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  'Iniciar sesión',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
              ),
              onPressed: () {}),
          const SizedBox(height: 20),
          Text(
            '¿Olvidaste tu contraseña?',
            style: GoogleFonts.roboto(
                color: const Color.fromRGBO(0, 152, 181, 1),
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
