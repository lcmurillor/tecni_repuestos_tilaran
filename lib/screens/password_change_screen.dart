import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
      useImg: true,
      useBackArrow: true,
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 170),
              CardContainer(
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
              const SizedBox(height: 45)
            ],
          )),
    ));
  }
}

class _UpdatePasswordForm extends StatelessWidget {
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
