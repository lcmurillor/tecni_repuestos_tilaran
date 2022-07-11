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
        body: StreamBuilder(
          stream: FirebaseFirestoreService.getUserByUid(
              FirebaseAuthService.auth.currentUser!.uid),
          builder:
              //TODO: ver si podemos cambiar esto de una lista de usuarios a un único usuario
              (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
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
                Align(
                  alignment: Alignment.center,
                  //TODO: Ver si es posible empezar a implementar la foto de perfil por usuario.
                  child: CircleAvatar(
                    child: Text(
                      //TODO: Buscar una manera mas eficiente para hacer referencia a un único usuario en ves de la primera posisicon de un arreglo.
                      user[0].name.substring(0, 1).toUpperCase() +
                          '' +
                          user[0].lastname.substring(0, 1).toUpperCase(),
                      style: CustomTextStyle.robotoMedium
                          .copyWith(fontSize: 50, color: Colors.white),
                    ),
                    backgroundColor: ColorStyle.mainGrey,
                    maxRadius: 58,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                    user[0].name.toUpperCase() +
                        ' ' +
                        user[0].lastname.toUpperCase(),
                    style:
                        CustomTextStyle.robotoExtraBold.copyWith(fontSize: 20)),
                const SizedBox(
                  height: 7,
                ),
                Text(user[0].email,
                    style: CustomTextStyle.robotoSemiBold
                        .copyWith(fontSize: 15, color: ColorStyle.textGrey)),
                const SizedBox(
                  height: 7,
                ),
                //TODO: Identificar si esto se puede mejorar, para que se puedan agregar telefonos de diferentes paises, o que el usuario identifique su código de pais.
                Text('+506 ' + user[0].phone,
                    style: CustomTextStyle.robotoSemiBold
                        .copyWith(fontSize: 16, color: ColorStyle.mainRed)),
                const SizedBox(
                  height: 7,
                ),
                Text(
                    DateFormat('dd-MM-yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(user[0].birthdate)),
                    style: CustomTextStyle.robotoExtraBold
                        .copyWith(fontSize: 15, color: ColorStyle.textGrey)),
                const SizedBox(height: 20),
                InfoButton(
                  icon: MdiIcons.accountEdit,
                  onPressed: () {
                    Navigator.pushNamed(context, 'editInformation');
                  },
                  text: 'Editar mi información',
                ),
                InfoButton(
                  icon: MdiIcons.formTextboxPassword,
                  onPressed: () {
                    Navigator.pushNamed(context, 'passwordChange');
                  },
                  text: 'Cambiar mi contraseña',
                ),
                InfoButton(
                  icon: MdiIcons.mapPlus,
                  onPressed: () {
                    Navigator.pushNamed(context, 'addresses');
                  },
                  text: 'Gestionar Direcciones',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
