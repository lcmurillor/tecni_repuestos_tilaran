import 'package:flutter/material.dart';
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Regístrate',
                              style: CustomTextStyle.robotoSemiBold
                                  .copyWith(fontSize: 45)),
                          const SizedBox(
                            height: 15,
                          ),
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
  bool _isactived = false;

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
                if (value == null || value.isEmpty) {
                  return 'El email es obligatorio';
                }
                return null;
              }),

          ///Input correspondiente al nombre  para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Nombre',
              icon: Icons.person,
              onChanged: (value) => registerFormProvider.name = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              }),

          ///Input correspondiente al nombre  para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Apellidos',
              icon: Icons.person,
              onChanged: (value) => registerFormProvider.name = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
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
                  return 'El teléfono es obligatorio';
                }
                return null;
              }),

          ///Input correspondiente al fecha para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Fecha de nacimiento',
              icon: Icons.calendar_month_rounded,
              onChanged: (value) => registerFormProvider.dateofbirth = value,
              keyboardType: TextInputType.datetime,
              controller: _dateController,
              readOnly: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La fecha de nacimiento es obligatoria';
                }
                return null;
              },
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
                    //TODO evaluar si es en este formato, como se guardan los datos en la base de datos.
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
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
                  return 'La contraseña debe de tener más de 6 caracteres';
                }
                return null;
              }),

          ///Input correspondiente al a contraseña para registrar el nuevo usuario.
          CustomTextInput(
              hintText: 'Confirmar contraseña',
              icon: Icons.lock,
              onChanged: (value) =>
                  registerFormProvider.confirmpassword = value,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su contraseña';
                }
                if (value.length < 6) {
                  return 'La contraseña debe de tener más de 6 caracteres';
                }
                return null;
              }),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 40),
                child: Checkbox(
                  activeColor: ColorStyle.mainRed,
                  value: _isactived,
                  onChanged: (bool? valueIn) {
                    setState(() {
                      _isactived = valueIn!;
                    });
                  },
                ),
              ),
              Text('Términos y condiciones',
                  style: CustomTextStyle.robotoSemiBold
                      .copyWith(color: ColorStyle.mainBlue)),
            ],
          ),
          //TODO Crear el metodo de validación y cración de usuarios.
          PrimaryButton(
              text: 'Crear cuenta',
              onPressed: () => registerFormProvider.validateForm(_isactived))
        ],
      ),
    );
  }
}
