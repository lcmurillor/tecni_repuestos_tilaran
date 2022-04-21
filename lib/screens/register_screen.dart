import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          padding: const EdgeInsets.all(1),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, 'login');
                            },
                            child: Text(
                              'Inicia Sesión',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: const Color.fromRGBO(0, 152, 181, 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )),
            )),
          );
        }));
  }
}

class _RegisterForm extends StatelessWidget {
  final _dateController = TextEditingController();
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
              return null;
            },
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputStyle.mainInput(
                hintText: 'Correo Electrónico', icon: Icons.email_rounded),
          ),
          const SizedBox(height: 15),
          TextFormField(
            onChanged: (value) => registerFormProvider.name = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El nombre es obligatorio';
              }
              return null;
            },
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.name,
            decoration:
                InputStyle.mainInput(hintText: 'Nombre', icon: Icons.person),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Los apellidos son obligatorios';
              }
              return null;
            },
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.name,
            decoration: InputStyle.mainInput(
                hintText: 'Apellidos', icon: Icons.person),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El teléfono es obligatorio';
              }
              return null;
            },
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.phone,
            decoration:
                InputStyle.mainInput(hintText: 'Teléfono', icon: Icons.phone),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _dateController,
            readOnly: true,
            onTap: () async {
              await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2080),
                  locale: const Locale('es'),
                  builder: (BuildContext context, child) {
                    return Theme(
                        data: ThemeData.light().copyWith(
                            colorScheme: const ColorScheme.light(
                          primary: Color.fromRGBO(214, 39, 31, 1),
                        )),
                        child: child!);
                  }).then((selectedDate) {
                if (selectedDate != null) {
                  _dateController.text =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                }
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La fecha de nacimiento es obligatoria';
              }
              return null;
            },
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.datetime,
            decoration: InputStyle.mainInput(
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
            decoration: InputStyle.mainInput(
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
            decoration: InputStyle.mainInput(
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
                'Términos y condiciones',
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
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: const Color.fromRGBO(0, 152, 181, 1)),
            ),
          ),
          const SizedBox(height: 14)
        ],
      ),
    );
  }
}
