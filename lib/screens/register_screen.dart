import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/screens/ui/input_decorations.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
          body: Background(
        useImg: false,
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 90),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Regístrate',
                      style: GoogleFonts.roboto(
                          fontSize: 45, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 15,
                  ),
                  _RegisterForm()
                ],
              ),
            ),
            const SizedBox(height: 15),
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
          const SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Nombre', directionIcon: 'assets/person.svg'),
          ),
          const SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Apellidos', directionIcon: 'assets/person.svg'),
          ),
          const SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Teléfono', directionIcon: 'assets/phone.svg'),
          ),
          const SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Fecha de nacimiento',
                directionIcon: 'assets/date.svg'),
          ),
          const SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Contraseña', directionIcon: 'assets/phone.svg'),
          ),
          const SizedBox(height: 15),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Confirmar contraseña',
                directionIcon: 'assets/phone.svg'),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 40),
                child: Checkbox(
                  activeColor: const Color.fromRGBO(214, 39, 31, 1),
                  onChanged: (bool? value) {},
                  value: true,
                ),
              ),
              Text(
                'Términos y condicones',
                style: GoogleFonts.roboto(
                    color: const Color.fromRGBO(0, 152, 181, 1),
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              disabledColor: Colors.grey,
              color: const Color.fromRGBO(214, 39, 31, 1),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                child: Text(
                  'Crear cuenta',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
              ),
              onPressed: () {}),
          const SizedBox(height: 15),
          Text(
            '¿Olvidaste tu contraseña?',
            style: GoogleFonts.roboto(
                color: const Color.fromRGBO(0, 152, 181, 1),
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14)
        ],
      ),
    );
  }
}
