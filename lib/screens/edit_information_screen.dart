import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';
//import 'package:url_launcher/url_launcher_string.dart';

class EditInformationScreen extends StatelessWidget {
  const EditInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RegisterFormProvider(),
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
                          Text('Editar mi información',
                              style: CustomTextStyle.robotoSemiBold
                                  .copyWith(fontSize: 30)),
                          const SizedBox(height: 15),
                          _RegisterForm(),
                          SecundaryButton(
                              text: "Regresar",
                              fontSize: 16,
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, 'home');
                              })
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
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
  final bool _isActived = false;

  @override
  Widget build(BuildContext context) {
    final registerFormProvider =
        Provider.of<RegisterFormProvider>(context, listen: false);
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
          key: registerFormProvider.formKey,
          child: Column(
            children: [
              ///Input correspondiente al correo electronico para registrar el nuevo usuario.

              ///Input correspondiente al nombre  para registrar el nuevo usuario.
              CustomTextInput(
                  controller: TextEditingController(text: user[0].name),
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
                  controller: TextEditingController(text: user[0].lastname),
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
                      registerFormProvider.dateofbirth = int.parse(value),
                  keyboardType: TextInputType.datetime,
                  controller: TextEditingController(
                      text: DateFormat('dd-MM-yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              user[0].birthdate))),
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
                        initialDate: DateTime.fromMillisecondsSinceEpoch(
                            user[0].birthdate),
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
                        TextEditingController(
                            text:
                                DateFormat('yyyy-MM-dd').format(selectedDate));
                        //print(selectedDate.millisecondsSinceEpoch);
                        registerFormProvider.dateofbirth =
                            selectedDate.millisecondsSinceEpoch;
                      }
                    });
                  }),

              const SizedBox(height: 5),
              PrimaryButton(
                  text: 'Aplicar cambio',
                  onPressed: () => _onFormSubmit(
                      registerFormProvider, context, _isActived, user[0]))
            ],
          ),
        );
      },
    );
  }
}

void _onFormSubmit(RegisterFormProvider registerFormProvider, context,
    bool isActived, UserModel user) {
  final isValid = registerFormProvider.validateForm(isActived);
  user = UserModel(
      birthdate: registerFormProvider.dateofbirth,
      email: user.email,
      id: user.id,
      lastname: registerFormProvider.lastname,
      name: registerFormProvider.name,
      phone: registerFormProvider.phone);
  if (isValid) {
    FirebaseCloudService.updateUser(user);
    // FirebaseAuthService.logIn(registerFormProvider.email,
    //     registerFormProvider.password, user, context);
  }
}
