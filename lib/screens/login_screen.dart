import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, this.hasError = false}) : super(key: key);
  final bool hasError;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(builder: (context) {
          Future.delayed(Duration.zero, () {
            if (hasError) {
              NotificationsService.showSnackbar(
                  'Ha ocurrido un error al iniciar sesión.');
            }
          });
          return Scaffold(
              body: Background(
            useImg: true,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 180),
                    CardContainer(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          // ,
                          Text('Iniciar Sesión',
                              style: CustomTextStyle.robotoSemiBold
                                  .copyWith(fontSize: size.width * 0.11)),
                          const SizedBox(
                            height: 30,
                          ),
                          _LoginForm()
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TertiaryButton(
                        text: '¿No tiene una cuenta?',
                        buttonText: 'Regístrate ahora',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'register');
                        })
                  ],
                )),
          ));
        }));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginFormProvider =
        Provider.of<LoginFormProvider>(context, listen: false);
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: loginFormProvider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///Input correspondiente al correo electronico solicitado para iniciar sesión.
          CustomTextInput(
              hintText: 'Correo Electrónico',
              icon: Icons.email,
              onChanged: (value) => loginFormProvider.email = value,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) =>
                  _onFormSubmit(loginFormProvider, context),
              validator: (value) {
                if (!EmailValidator.validate(value ?? '')) {
                  return 'Email no válido';
                } else {
                  return null;
                }
              }),

          ///Input correspondiente a la contraseña solicitado para iniciar sesión.
          CustomTextInput(
              hintText: 'Contraseña',
              icon: Icons.lock,
              obscureText: true,
              onFieldSubmitted: (_) =>
                  _onFormSubmit(loginFormProvider, context),
              onChanged: (value) => loginFormProvider.password = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su contraseña';
                }
                if (value.length < 6) {
                  return 'Debe tener más de 6 caractéres';
                }
                return null;
              }),
          PrimaryButton(
              text: 'Iniciar sesión',
              onPressed: () => _onFormSubmit(loginFormProvider, context)),
          const SizedBox(height: 10),
          SecundaryButton(
              text: '¿Olvidaste tu contraseña?',
              fontSize: 16,
              onPressed: () {}),
        ],
      ),
    );
  }
}

///Función intermedia que hace una llamado a la base de datos para optener un usuario
///si éste está registrado, de ahí se hacen el resto de evaluaciones de autetificación.
void _onFormSubmit(LoginFormProvider loginFormProvider, BuildContext context) {
  FirebaseCloudService.getUserByEmail(loginFormProvider.email).then(
      (UserModel? user) => _validateData(user, loginFormProvider, context));
}

///Función de evalución final, evalua que el formulario cumpla con los requerimientos
///mínimos y si el usuario registrado está activo en el sistema. Si se cumplen las condiciones
///se puede iniciar la sesión.
void _validateData(UserModel? user, LoginFormProvider loginFormProvider,
    BuildContext context) {
  if (null != user && !user.disabled && loginFormProvider.validateForm()) {
    FirebaseAuthService.signIn(
        loginFormProvider.email, loginFormProvider.password, context);
  } else {
    NotificationsService.showSnackbar(
        'El ususario indicado no está registrado.');
  }
}
