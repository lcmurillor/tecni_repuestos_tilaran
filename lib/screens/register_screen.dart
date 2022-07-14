import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RegisterScreen extends StatelessWidget {
  ///En esta pantalla un usuario nuevo puede registrarese en la aplicación ingresando su información
  ///personal básica. Estos datos son requeridos para faciliar porcesos de facturación y compras a
  ///niveles administrativos.
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
                    const SizedBox(height: 40),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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

///En este widget se crea el formulario con el cual se evaluan las condiciones de los datos ingresados
///a la hora de crear un nuevo usuario, cada entrada tiene un formato esperado. si se cumple el formato
///se envía todos los datos del formulario cargado a una función la cual registra el usuario y
///guarda los datos en la base de datos.
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
                  return 'El nombre es obligatorio.';
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
                  return 'El apellido es obligatorio.';
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
                } else if (value.length > 8 || value.length < 8) {
                  return 'El teléfono no es valido.';
                }
                return null;
              }),

          ///Input correspondiente al fecha para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Fecha de nacimiento',
              icon: Icons.calendar_month_rounded,
              onChanged: (value) =>
                  registerFormProvider.birthdate = int.parse(value),
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
                        DateFormat('dd-MM-yyyy').format(selectedDate);
                    //print(selectedDate.millisecondsSinceEpoch);
                    registerFormProvider.birthdate =
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
                  return 'Ingrese su contraseña.';
                }
                if (value.length < 6) {
                  return 'La contraseña debe de tener más de 6 caracteres.';
                }
                return null;
              }),

          ///Input correspondiente al a contraseña para registrar el nuevo usuario.
          CustomTextInput(
              height: 5,
              hintText: 'Confirmar contraseña',
              icon: Icons.lock,
              onChanged: (value) =>
                  registerFormProvider.confirmPassword = value,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su contraseña.';
                }
                if (value.length < 6) {
                  return 'La contraseña debe de tener más de 6 caracteres.';
                }
                return null;
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                activeColor: ColorStyle.mainRed,
                value: _isActived,
                onChanged: (bool? valueIn) {
                  setState(() {
                    _isActived = valueIn!;
                  });
                },
              ),
              const SecundaryButton(
                  text: "Términos y condiciones",
                  fontSize: 16,
                  onPressed: _launchURL)
            ],
          ),
          const SizedBox(height: 5),
          PrimaryButton(
              text: 'Crear cuenta',
              onPressed: () =>
                  _onFormSubmit(registerFormProvider, context, _isActived))
        ],
      ),
    );
  }
}

///Evalua que el formualrio cumpla con las condiciones mínimas, si es así, se registra un usuario en la base
///de datos de Firebase, seguidamente se guardan estos datos en la base de datos y se asocian los datos de
///autentificación.
void _onFormSubmit(
    RegisterFormProvider registerFormProvider, context, bool isActived) {
  final isValid = registerFormProvider.validateForm(isActived);
  UserModel user = UserModel(
    birthdate: registerFormProvider.birthdate,
    email: registerFormProvider.email,
    id: 'undefied',
    identification: 'undefied',
    identificationType: 'undefied',
    lastname: registerFormProvider.lastname,
    name: registerFormProvider.name,
    phone: registerFormProvider.phone,
    profileImg: 'undefied',
  );
  if (isValid) {
    FirebaseAuthService.logIn(registerFormProvider.email,
        registerFormProvider.password, user, context);
  }
}

///En este aprtado podemos agregar un enlace directo a una página con los términos y condiciones
///para los usuarios de la aplicación.
void _launchURL() async {
  const url = 'https://es.lipsum.com/';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    NotificationsService.showErrorSnackbar('No se pudo motrar la página.');
  }
}
