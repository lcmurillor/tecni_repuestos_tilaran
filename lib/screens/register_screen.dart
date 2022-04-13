import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/screens/ui/input_decorations.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ChangeNotifierProvider(
        create: (_) => RegisterFormProvider(),
        child: Builder(builder: (context) {
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
                            '¿Ya tienes una cuenta?',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            ' Inicia Sesión',
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
        }));
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerFormProvider =
        Provider.of<RegisterFormProvider>(context, listen: false);
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: registerFormProvider.formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) => registerFormProvider.email = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El email es obligatorio';
              }
            },
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Correo Electrónico', icon: Icons.email_rounded),
          ),
          const SizedBox(height: 15),
          TextFormField(
            onChanged: (value) => registerFormProvider.name = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El nombre es obligatorio';
              }
            },
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.loginScreen(
                hintText: 'Nombre', icon: Icons.person),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Los apellidos son obligatorios';
              }
            },
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.loginScreen(
                hintText: 'Apellidos', icon: Icons.person),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El teléfono es obligatorio';
              }
            },
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecorations.loginScreen(
                hintText: 'Teléfono', icon: Icons.phone),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La fecha de nacimiento es obligatoria';
              }
            },
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.datetime,
            decoration: InputDecorations.loginScreen(
                hintText: 'Fecha de nacimiento',
                icon: Icons.calendar_month_rounded),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su contraseña';
              }
              if (value.length < 6) {
                return 'La contraseña debe de tener más de 6 caracteres';
              }
              return null;
            },
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.loginScreen(
                hintText: 'Contraseña', icon: Icons.lock),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su contraseña';
              }
              if (value.length < 6) {
                return 'La contraseña debe de tener más de 6 caracteres';
              }
              return null;
            },
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.loginScreen(
                hintText: 'Confirmar contraseña', icon: Icons.lock),
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
              onPressed: () {
                registerFormProvider.validateForm();
              }),
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
