import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/shared/preferences.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

class UserInformationScreen extends StatelessWidget {
  ///Ésta pantalla corresponde al apartado donde el usuario puede editar su información.
  ///Se muestra un formulario el cual esta previamente cargado con la información del usuario registrado
  ///en este, el usuario puede editar lo que necesite.
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
      useBackArrow: true,
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text('Editar mi información',
                          style: CustomTextStyle.robotoSemiBold
                              .copyWith(fontSize: 30)),
                      const SizedBox(height: 15),
                      _EditInfoForm(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 45)
            ],
          )),
    ));
  }
}

///Formulario el cual se carga con la información del usuario registrado en la aplicación y en donde este
///puede editar sus datos personales.
class _EditInfoForm extends StatelessWidget {
  _EditInfoForm({Key? key}) : super(key: key);
  final _dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditInfoFormProvider(),
      child: Builder(builder: (context) {
        final editInfoFormProvider =
            Provider.of<EditInfoFormProvider>(context, listen: false);
        return FutureBuilder(
          future: FirebaseRealtimeService.getUserByUid(
              uid: FirebaseAuthService.auth.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
            if (snapshot.hasError) {
              return NotificationsService.showErrorSnackbar(
                  'Ha ocurrido un error a la hora de cargar los datos.');
            }

            if (!snapshot.hasData) {
              return const CustomProgressIndicator();
            }

            final user = snapshot.data!;
            return Form(
              key: editInfoFormProvider.formKey,
              child: Column(
                children: [
                  ///Input correspondiente al nombre  para registrar el nuevo usuario.
                  CustomTextInput(
                      controller: TextEditingController(text: user.name),
                      hintText: 'Nombre',
                      icon: Icons.person,
                      onChanged: (value) => editInfoFormProvider.name = value,
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
                      controller: TextEditingController(text: user.lastname),
                      hintText: 'Apellidos',
                      icon: Icons.person,
                      onChanged: (value) =>
                          editInfoFormProvider.lastname = value,
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
                      controller: TextEditingController(text: user.phone),
                      hintText: 'Teléfono',
                      icon: Icons.phone,
                      onChanged: (value) => editInfoFormProvider.phone = value,
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
                          editInfoFormProvider.birthdate = int.parse(value),
                      keyboardType: TextInputType.datetime,
                      controller: _dataController
                        ..text = DateFormat('dd-MM-yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                user.birthdate)),
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
                                user.birthdate),
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
                            _dataController.text =
                                DateFormat('dd-MM-yyyy').format(selectedDate);
                            editInfoFormProvider.birthdate =
                                selectedDate.millisecondsSinceEpoch;
                          }
                        });
                      }),
                  //Input correspondiente del tipo de identificación para registrar el nuevo usuario.
                  DropdownButtonFormField<int>(
                    style: CustomTextStyle.robotoSemiBold.copyWith(
                        color: (Preferences.isDarkmode)
                            ? Colors.white
                            : Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    decoration: InputStyle.mainInput(
                        hintText: '', icon: MdiIcons.fileAccount),

                    value:
                        1, //Este será el valor por defecto al dibujar el widget
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Cédula de identidad'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Persona Jurídica'),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text('Pasaporte'),
                      ),
                    ],
                    onChanged: (value) {
                      editInfoFormProvider.identificationType = value ?? 1;
                    },
                  ),
                  const SizedBox(height: 15),

                  ///Input correspondiente de la identificación para registrar el nuevo usuario.
                  CustomTextInput(
                      controller:
                          TextEditingController(text: user.identification),
                      keyboardType: TextInputType.number,
                      hintText: 'Cédula',
                      icon: MdiIcons.cardAccountDetails,
                      onChanged: (value) =>
                          editInfoFormProvider.identification = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'La cédula es obligatoria.';
                        } else if (value.length < 7) {
                          return 'El cédula debe contener 7 o más caracteres.';
                        }
                        return null;
                      }),

                  const SizedBox(height: 5),
                  PrimaryButton(
                      text: 'Aplicar cambio',
                      onPressed: () =>
                          _onFormSubmit(editInfoFormProvider, context, user))
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

///Evalua si el formulario cumple con las condiciones mínimas para ser aceptado, además
///de que se cumplan con las validaciónes de los datos en la base de datos. Para los campos
///que no sean alterados por el usuario, asigna nuevamente los valores ya definidos y navega
///a la pantalla anterior.
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
        identification: (editInfoFormProvider.identification == '')
            ? user.identification
            : editInfoFormProvider.identification,
        identificationType: (editInfoFormProvider.identificationType == 0)
            ? user.identificationType
            : editInfoFormProvider.identificationType,
        lastname: (editInfoFormProvider.lastname == "")
            ? user.lastname
            : editInfoFormProvider.lastname,
        name: (editInfoFormProvider.name == "")
            ? user.name
            : editInfoFormProvider.name,
        phone: (editInfoFormProvider.phone == "")
            ? user.phone
            : editInfoFormProvider.phone,
        profileImg: user.profileImg,
      );
    } else {
      NotificationsService.showErrorSnackbar(
          'No se cumple con las condiciones mínimas para actualizar la información.');
    }
  }).then((value) {
    FirebaseRealtimeService.updateUser(user: user);
    if (editInfoFormProvider.validateForm()) {
      Navigator.pushReplacementNamed(context, 'profile');
      NotificationsService.showSnackbar(
          'Información actualizada correctamente.');
    }
  });
}
