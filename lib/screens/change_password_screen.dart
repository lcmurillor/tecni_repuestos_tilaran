import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UpdatePasswordProvider(),
        child: Builder(builder: (context) {
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
                          _EditInfoForm(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 45)
                  ],
                )),
          ));
        }));
  }
}

class _EditInfoForm extends StatelessWidget {
  _EditInfoForm({Key? key}) : super(key: key);
  //final _dataController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final editInfoFormProvider =
    //     Provider.of<EditInfoFormProvider>(context, listen: false);
    final updatePasswordProvider =
        Provider.of<UpdatePasswordProvider>(context, listen: false);
    //  final updatePasswordProvider =
    //     Provider.of<updatePasswordProvider>(context, listen: false);
    return StreamBuilder(
      stream: FirebaseCloudService.getUserByUid(
          FirebaseAuthService.auth.currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return NotificationsService.showErrorSnackbar(
              'Ha ocurrido un error a la hora de cargar los datos.');
        }

        if (!snapshot.hasData) {
          return const CustomProgressIndicator();
        }

        final user = snapshot.data!;
        return Form(
          key: updatePasswordProvider.formKey,
          child: Column(
            children: [
              ///Input correspondiente al correo electronico para registrar el nuevo usuario.

              ///Input correspondiente al nombre  para registrar el nuevo usuario.
              CustomTextInput(
                  // controller: TextEditingController(text: user[0].nombre),
                  hintText: 'Contraseña actual',
                  obscureText: true,
                  icon: MdiIcons.formTextboxPassword,
                  onChanged: (value) {
                    if (value == updatePasswordProvider.password) {
                    } else {
                      return 'Contraseñas actuales no coinciden';
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    }
                    if (value.length < 6) {
                      return 'Debe tener más de 6 caractéres';
                    }
                    return null;
                  }),

              ///Input correspondiente al nombre  para registrar el nuevo usuario.
              CustomTextInput(
                  //  controller: TextEditingController(text: user[0].lastname),
                  hintText: 'Nueva contraseña',
                  obscureText: true,
                  icon: Icons.lock,
                  onChanged: (value) => updatePasswordProvider.password = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    }
                    if (value.length < 6) {
                      return 'Debe tener más de 6 caractéres';
                    }

                    return null;
                  }),

              ///Input correspondiente al Telefono para registrar el nuevo usuario.
              CustomTextInput(
                  //    controller: TextEditingController(text: user[0].phone),
                  hintText: 'Confirmar nueva contraseña',
                  obscureText: true,
                  icon: Icons.lock,
                  onChanged: (value) => updatePasswordProvider.password = value,
                  //   keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    }
                    if (value.length < 6) {
                      return 'Debe tener más de 6 caractéres';
                    }
                    return null;
                  }),

              ///Input correspondiente al fecha para registrar el nuevo usuario.

              const SizedBox(height: 5),
              PrimaryButton(
                  text: 'Aplicar cambio',
                  onPressed: () =>
                      _onFormSubmitPassword(updatePasswordProvider, context))
            ],
          ),
        );
      },
    );
  }
}

void _onFormSubmitPassword(
  UpdatePasswordProvider updatePasswordProvider,
  BuildContext context,
) {
  if (updatePasswordProvider.validateForm()) {
    FirebaseAuthService.updatePassword(
        updatePasswordProvider.password, context);
  } else {
    NotificationsService.showErrorSnackbar(
        'Su contraseña no cumple los requisitos mínimos');
  }
}

///Función de evalución final, evalua que el formulario cumpla con los requerimientos
///mínimos y si el usuario registrado está activo en el sistema. Si se cumplen las condiciones
///se puede iniciar la sesión.




