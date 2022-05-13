import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
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
  final _dataController = TextEditingController();
  final String newpassword = '0';
  @override
  Widget build(BuildContext context) {
    // final editInfoFormProvider =
    //     Provider.of<EditInfoFormProvider>(context, listen: false);
    final loginFormProvider =
        Provider.of<LoginFormProvider>(context, listen: false);
    var newPassword = '';
    //  final loginFormProvider =
    //     Provider.of<LoginFormProvider>(context, listen: false);
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
          key: loginFormProvider.formKey,
          child: Column(
            children: [
              ///Input correspondiente al correo electronico para registrar el nuevo usuario.

              ///Input correspondiente al nombre  para registrar el nuevo usuario.
              CustomTextInput(
                  // controller: TextEditingController(text: user[0].nombre),
                  hintText: 'Contraseña actual',
                  icon: MdiIcons.formTextboxPassword,
                  onChanged: (value) {
                    loginFormProvider.password = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    }
                    if (value.length < 6) {
                      return 'Debe tener más de 6 caractéres';
                    }
                    return value;
                  }),

              ///Input correspondiente al nombre  para registrar el nuevo usuario.
              CustomTextInput(
                  //  controller: TextEditingController(text: user[0].lastname),
                  hintText: 'Nueva contraseña',
                  icon: Icons.lock,
                  onChanged: (value) => value = loginFormProvider.password,
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
                  icon: Icons.lock,
                  onChanged: (value) => value = loginFormProvider.password,
                  //   keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    }
                    if (value.length < 6) {
                      return 'Debe tener más de 6 caractéres';
                    }
                    newPassword = value;
                    return newPassword;
                  }),

              ///Input correspondiente al fecha para registrar el nuevo usuario.

              const SizedBox(height: 5),
              PrimaryButton(
                  text: 'Aplicar cambio',
                  onPressed: () =>
                      _onFormSubmitPassword(loginFormProvider, context))
            ],
          ),
        );
      },
    );
  }
}

void _onFormSubmitPassword(
  LoginFormProvider loginFormProvider,
  BuildContext context,
) {
  FirebaseCloudService.getUserByEmail(loginFormProvider.email)
      .then((UserModel? user) => _validateData(loginFormProvider, context));
}

///Función de evalución final, evalua que el formulario cumpla con los requerimientos
///mínimos y si el usuario registrado está activo en el sistema. Si se cumplen las condiciones
///se puede iniciar la sesión.
void _validateData(
  LoginFormProvider loginFormProvider,
  BuildContext context,
) {
  final isValid = loginFormProvider.validateForm();
  if (loginFormProvider.email == loginFormProvider.email) {
    FirebaseAuthService.auth;
  } else {
    NotificationsService.showErrorSnackbar(
        'El usuario indicado no está registrado.');
  }
}

void _onFormSubmit(
    EditInfoFormProvider editInfoFormProvider, context, UserModel user) async {
  Future.delayed(Duration.zero, () {
    if (editInfoFormProvider.validateForm()) {
      user = UserModel(
          birthdate: (editInfoFormProvider.birthdate == 0)
              ? user.birthdate
              : editInfoFormProvider.birthdate,
          email: user.email,
          id: user.id,
          lastname: (editInfoFormProvider.lastname == "")
              ? user.lastname
              : editInfoFormProvider.lastname,
          name: (editInfoFormProvider.name == "")
              ? user.name
              : editInfoFormProvider.name,
          phone: (editInfoFormProvider.phone == "")
              ? user.phone
              : editInfoFormProvider.phone);
    } else {
      NotificationsService.showErrorSnackbar(
          'No se cumple con las condiciones mínimas para actualizar la información.');
    }
  }).then((value) {
    FirebaseCloudService.updateUser(user);
    Navigator.pop(context);
  });
}
