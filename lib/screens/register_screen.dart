import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

//external int get millisecondsSinceEpoch;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RegisterFormProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
              body: Background(
            useImg: false,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 90),
                    CardContainer(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text('Regístrate',
                              style: CustomTextStyle.robotoSemiBold
                                  .copyWith(fontSize: 45)),
                          const SizedBox(height: 15),
                          _RegisterForm()
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TertiaryButton(
                        text: '¿Ya tiene una cuenta?',
                        buttonText: 'Iniciar sesión',
                        onPressed: () => Navigator.pushNamed(context, 'login')),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )),
          ));
        }));
  }
}

class _RegisterForm extends StatefulWidget {
  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  bool _isActived = false;

  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerFormProvider =
        Provider.of<RegisterFormProvider>(context, listen: false);
    return Form(
      key: registerFormProvider.formKey,
      child: Column(
        children: [
          ///Input correspondiente al correo electronico para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Correo Electrónico',
              icon: Icons.email_rounded,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => registerFormProvider.email = value,
              validator: (value) {
                if (!EmailValidator.validate(value ?? '')) {
                  return 'El correo no es válido.';
                } else {
                  return null;
                }
              }),

          ///Input correspondiente al nombre  para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Nombre',
              icon: Icons.person,
              onChanged: (value) => registerFormProvider.name = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                } else if (value.length < 2) {
                  return 'EL nombre debe tener 2 o más caracteres.';
                }
                return null;
              }),

          ///Input correspondiente al nombre  para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Apellidos',
              icon: Icons.person,
              onChanged: (value) => registerFormProvider.lastname = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El apellido es obligatorio';
                } else if (value.length < 2) {
                  return 'El apellido debe tener 2 o más caracteres.';
                }
                return null;
              }),

          ///Input correspondiente al Telefono para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Teléfono',
              icon: Icons.phone,
              onChanged: (value) => registerFormProvider.phone = value,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El teléfono es obligatorio.';
                } else if (value.length > 8) {
                  return 'El teléfono no es valido.';
                }
                return null;
              }),

          ///Input correspondiente al fecha para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Fecha de nacimiento',
              icon: Icons.calendar_month_rounded,
              onChanged: (value) =>
                  registerFormProvider.dateofbirth = int.parse(value),
              keyboardType: TextInputType.datetime,
              controller: _dateController,
              readOnly: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La fecha de nacimiento es obligatoria.';
                }
                return null;
              },
              onTap: () async {
                await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    locale: const Locale('es'),
                    builder: (BuildContext context, child) {
                      return Theme(
                          data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                            primary: ColorStyle.mainRed,
                          )),
                          child: child!);
                    }).then((selectedDate) {
                  if (selectedDate != null) {
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                    //print(selectedDate.millisecondsSinceEpoch);
                    registerFormProvider.dateofbirth =
                        selectedDate.millisecondsSinceEpoch;
                  }
                });
              }),

          ///Input correspondiente al a contraseña para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Contraseña',
              icon: Icons.lock,
              onChanged: (value) => registerFormProvider.password = value,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su contraseña';
                }
                if (value.length < 6) {
                  return 'La contraseña debe de tener más de 6 caracteres.';
                }
                return null;
              }),

          ///Input correspondiente al a contraseña para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Confirmar contraseña',
              icon: Icons.lock,
              onChanged: (value) =>
                  registerFormProvider.confirmPassword = value,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su contraseña';
                }
                if (value.length < 6) {
                  return 'La contraseña debe de tener más de 6 caracteres.';
                }
                return null;
              }),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 40),
                child: Checkbox(
                  activeColor: ColorStyle.mainRed,
                  value: _isActived,
                  onChanged: (bool? valueIn) {
                    setState(() {
                      _isActived = valueIn!;
                    });
                  },
                ),
              ),
              const SecundaryButton(
                  text: "Términos y condiciones",
                  fontSize: 16,
                  onPressed: _launchURL)
            ],
          ),
          PrimaryButton(
              text: 'Crear cuenta',
              onPressed: () =>
                  _onFormSubmit(registerFormProvider, context, _isActived))
        ],
      ),
    );
  }
}

void _onFormSubmit(
    RegisterFormProvider registerFormProvider, context, bool isActived) {
  final isValid = registerFormProvider.validateForm(isActived);
  UserModel user = UserModel(
      birthdate: registerFormProvider.dateofbirth,
      email: registerFormProvider.email,
      id: 'undefied',
      lastname: registerFormProvider.lastname,
      name: registerFormProvider.name,
      phone: registerFormProvider.phone);
  if (isValid) {
    FirebaseAuthService.logIn(registerFormProvider.email,
        registerFormProvider.password, user, context);
  }
}

void _launchURL() async {
  const url = 'https://es.lipsum.com/';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    NotificationsService.showSnackbar('No se pudo motrar la página');
  }
}
