import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/shared/preferences.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  ///Esta pantalla muestra la información básica del usuario correspondiente a su perfil
  ///junto con botones los cuales lo redirigen a más opciones de personalización relacionadas
  ///con su información personal.
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(

            /// Se utiliza ese AppBar personalizado ya que es requerido para la navegación del usuario
            /// además, en este AppBar es donde se encuentra el botón para cambiar el tema de la aplicación.
            appBar: CustomAppBarBackArrow(
              actionIcon:
                  (Preferences.isDarkmode) ? Icons.dark_mode : Icons.light_mode,
              iconColor:
                  (Preferences.isDarkmode) ? Colors.white : ColorStyle.mainGrey,
              onPressed: () {
                setState(() {
                  Preferences.isDarkmode = !Preferences.isDarkmode;
                  if (Preferences.isDarkmode) {
                    themeProvider.setDarkMode();
                  } else {
                    themeProvider.setLigthMode();
                  }
                });
              },
              navigatorOnPressed: () => Navigator.pushNamed(context, 'home'),
            ),
            body: FutureBuilder(
              ///Resive la consulta de la base de datos.
              future: FirebaseRealtimeService.getUserByUid(
                  uid: FirebaseAuthService.auth.currentUser!.uid),

              builder:
                  (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
                if (snapshot.hasError) {
                  return NotificationsService.showErrorSnackbar(
                      'Ha ocurrido un error a la hora de cargar los datos.');
                }

                if (!snapshot.hasData) {
                  return const CustomProgressIndicator();
                }
                final user = snapshot.data!;
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            child: Text(
                              user.name.substring(0, 1).toUpperCase() +
                                  '' +
                                  user.lastname.substring(0, 1).toUpperCase(),
                              style: CustomTextStyle.robotoMedium
                                  .copyWith(fontSize: 50, color: Colors.white),
                            ),
                            backgroundColor: ColorStyle.mainGrey,
                            maxRadius: 58,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          color: Colors.amber,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                        user.name.toUpperCase() +
                            ' ' +
                            user.lastname.toUpperCase(),
                        style: CustomTextStyle.robotoExtraBold
                            .copyWith(fontSize: 20)),
                    const SizedBox(height: 7),
                    Text(user.email,
                        style: CustomTextStyle.robotoSemiBold.copyWith(
                            fontSize: 15, color: ColorStyle.textGrey)),
                    const SizedBox(height: 7),
                    Text('+506 ' + user.phone,
                        style: CustomTextStyle.robotoSemiBold
                            .copyWith(fontSize: 16, color: ColorStyle.mainRed)),
                    const SizedBox(height: 7),
                    Text(
                        DateFormat('dd-MM-yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                user.birthdate)),
                        style: CustomTextStyle.robotoExtraBold.copyWith(
                            fontSize: 15, color: ColorStyle.textGrey)),
                    const SizedBox(height: 20),
                    InfoButton(
                        icon: MdiIcons.accountEdit,
                        onPressed: () {
                          Navigator.pushNamed(context, 'editInformation');
                        },
                        text: 'Editar mi información'),
                    InfoButton(
                        icon: MdiIcons.formTextboxPassword,
                        onPressed: () {
                          Navigator.pushNamed(context, 'passwordChange');
                        },
                        text: 'Cambiar mi contraseña'),
                    InfoButton(
                        icon: MdiIcons.mapPlus,
                        onPressed: () {
                          Navigator.pushNamed(context, 'addresses');
                        },
                        text: 'Gestionar Direcciones'),
                  ],
                );
              },
            )));
  }
}
