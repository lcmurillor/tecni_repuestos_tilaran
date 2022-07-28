import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class UserPasswordScreen extends StatelessWidget {
  ///Corresponde a la pantalla en la cual el usuario puede cambiar su contraseña, escibiendo
  ///primeramente su contraseña actual y luego su nueva contraseña dos veces para comprobar que coincida.
  const UserPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Background(
        useImg: true,
        useBackArrow: true,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 170),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text('Cambiar contraseña',
                            style: CustomTextStyle.robotoExtraBold
                                .copyWith(fontSize: 28)),
                        const SizedBox(height: 20),
                        const _UpdatePasswordForm(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 45)
              ],
            )),
      )),
    );
  }
}

class _UpdatePasswordForm extends StatelessWidget {
  ///Éste widget es el formulario el cual permite al usuario registrarse ingresar los datos para cambiar
  ///su contraseña, envía la información a los correspondientes métodos para validar los datos ingresados,
  ///tanto la contraseña actual como la igualdad entre las nuevas contraseñas.
  const _UpdatePasswordForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UpdatePasswordFormProvider(),
        child: Builder(builder: (context) {
          final updatePasswordFormProvider =
              Provider.of<UpdatePasswordFormProvider>(context, listen: false);
          return Form(
              key: updatePasswordFormProvider.formKey,
              child: Column(children: [
                CustomTextInput(
                    hintText: 'Contraseña actual',
                    obscureText: true,
                    icon: Icons.lock,
                    onChanged: (value) =>
                        updatePasswordFormProvider.currentPassword = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su contraseña';
                      } else if (value.length < 6) {
                        return 'Debe tener más de 6 caractéres';
                      }
                      return null;
                    }),
                CustomTextInput(
                    hintText: 'Nueva contraseña',
                    obscureText: true,
                    icon: MdiIcons.formTextboxPassword,
                    onChanged: (value) =>
                        updatePasswordFormProvider.newPassword = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su contraseña';
                      }
                      if (value.length < 6) {
                        return 'Debe tener más de 6 caractéres';
                      }
                      return null;
                    }),
                CustomTextInput(
                    hintText: 'Confirmar contraseña',
                    obscureText: true,
                    icon: MdiIcons.formTextboxPassword,
                    onChanged: (value) =>
                        updatePasswordFormProvider.confirmNewPassword = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su contraseña';
                      }
                      if (value.length < 6) {
                        return 'Debe tener más de 6 caractéres';
                      }
                      return null;
                    },
                    height: 20),
                PrimaryButton(
                    text: 'Aplicar cambio',
                    onPressed: () =>
                        _onFormSubmit(updatePasswordFormProvider, context))
              ]));
        }));
  }
}

///Evalua que se cumplan las condicionas minimas respeto a los datos del formulario
///para cambiar la contraseña, si es así, manda los datos a los servicos de autentificación
///donde se evaluna la versidad de los datos.
void _onFormSubmit(
  UpdatePasswordFormProvider updatePasswordFormProvider,
  BuildContext context,
) {
  if (updatePasswordFormProvider.validateForm()) {
    FirebaseAuthService.updatePassword(
        updatePasswordFormProvider.currentPassword,
        updatePasswordFormProvider.newPassword,
        context);
  }
}
