import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class PasswordRequestScreen extends StatelessWidget {
  ///Ésta pantalla corresponde al método para recuperar la contraseña en caso de que el
  ///usuario haya olvidado la contraseña. En este espacio se valida que el correo cumpla con
  ///el respectivo formato y además que el correo corresponda a un usuario registrado y activo,
  ///si es así, se le envía un correo para cambiar su contraseña con las herramientas de Firebase.
  const PasswordRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
      useImg: true,
      useBackArrow: true,
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 180),
              Card(

                  ///Título, subtítulo y formulario del card de "¿Olvidaste tu contraseña?".
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('¿Olvidaste tu contraseña?',
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.robotoSemiBold
                            .copyWith(fontSize: size.width * 0.08)),
                    const SizedBox(height: 20),
                    Text(
                        'Por favor, ingrese el correo electrónico con el que está regsistrado.',
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.robotoMedium
                            .copyWith(fontSize: size.width * 0.04)),
                    const SizedBox(height: 20),

                    ///LLamado al formulario.
                    const _PasswordForm()
                  ],
                ),
              ))
            ],
          )),
    ));
  }
}

class _PasswordForm extends StatelessWidget {
  ///Formulario en el que se ingresa la el correo electrónico, se valida su formato
  ///y si corresponde a un usuario, si se comple, se hace un llamado a los métodos de
  ///autetintificación de los servicios de Firebase.
  const _PasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RequestPasswordFormProvider(),
      child: Builder(builder: (context) {
        final requestPasswordFormProvider =
            Provider.of<RequestPasswordFormProvider>(context, listen: false);
        return Form(
          key: requestPasswordFormProvider.formKey,
          child: Column(children: [
            CustomTextInput(
                height: 20,
                hintText: 'Correo Electrónico',
                icon: Icons.email,
                onChanged: (value) => requestPasswordFormProvider.email = value,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (!EmailValidator.validate(value ?? '')) {
                    return 'El correo no es válido.';
                  } else {
                    return null;
                  }
                }),
            PrimaryButton(
                text: 'Solicitar cambio',
                onPressed: () =>
                    _onFormSubmit(requestPasswordFormProvider, context)),
            SecundaryButton(
                text: 'Regresar',
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'))
          ]),
        );
      }),
    );
  }
}

///Función intermedia que hace una llamado a la base de datos para optener un usuario
///si éste está registrado.
void _onFormSubmit(RequestPasswordFormProvider requestPasswordFormProvider,
    BuildContext context) {
  // FirebaseFirestoreService.getUserByEmail(requestPasswordFormProvider.email)
  //     .then((UserModel? user) =>
  //         _validateData(user, requestPasswordFormProvider, context));
}

///Función de evalución final, evalua que el formulario cumpla con los requerimientos
///mínimos y si las credenciales indicadas corresponden a un usuario registrado.
void _validateData(
    UserModel? user,
    RequestPasswordFormProvider requestPasswordFormProvider,
    BuildContext context) {
  final isValid = requestPasswordFormProvider.validateForm();
  if (null != user && !user.disabled && isValid) {
    NotificationsService.showSnackbar(
        'Se ha enviado la solicitud de cambio a su correo electrónico ${requestPasswordFormProvider.email}');
    FirebaseAuthService.requestPassword(
        requestPasswordFormProvider.email, context);
  } else {
    NotificationsService.showErrorSnackbar(
        'El correo indicado no corresponde a ningún usuario.');
  }
}
