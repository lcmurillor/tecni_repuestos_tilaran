import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

import '../theme/themes.dart';
import 'screens.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key? key, this.hasError = false}) : super(key: key);
  final bool hasError;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Background(
          useBackArrow: true,
          useImg: false,
          child: Column(
            children: [
              const SizedBox(height: 110),
              Text('USUARIOS',
                  style: CustomTextStyle.robotoSemiBold.copyWith(
                      fontSize: size.width * 0.09, color: Colors.white)),
              const SizedBox(height: 60),
              Expanded(
                child: FirebaseAnimatedList(
                  ///Recibe la consulta de los usuarios de la base de datos.
                  query: FirebaseRealtimeService.getUsers(),
                  defaultChild: const CustomProgressIndicator(),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, snapshot, animation, index) {
                    if (!snapshot.exists) {
                      return NotificationsService.showErrorSnackbar(
                          'Ha ocurrido un error a la hora de cargar los datos.');
                    }
                    final user =
                        User.fromMap(jsonDecode(jsonEncode(snapshot.value)));
                    return MoldeInfoUsers(
                      user: user,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoldeInfoUsers extends StatelessWidget {
  const MoldeInfoUsers({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminUserProfileScreen(
              user: user,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            moldeRowInfo(Icons.person, user.name + ' ' + user.lastname,
                CustomTextStyle.robotoExtraBold),

            moldeRowInfo(Icons.email, user.email, CustomTextStyle.robotoMedium),
            // ,
            moldeRowInfo(Icons.phone, user.phone, CustomTextStyle.robotoMedium),
            moldeRowInfo(
                MdiIcons.accountCog,
                'Rol: ',
                CustomTextStyle.robotoMedium,
                (user.administrator)
                    ? 'Administrador'
                    : (user.vendor)
                        ? 'Vendedor'
                        : 'Usuario')
          ],
        ),
      ),
    );
  }
}

Padding moldeRowInfo(IconData icon, String text, TextStyle style,
    [String text2 = '']) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: Icon(
            icon,
            color: Colors.redAccent[700],
            size: 30,
          ),
        ),
        Text(text, style: style),
        Text(
          text2,
          style:
              CustomTextStyle.robotoMedium.copyWith(color: ColorStyle.mainBlue),
        ),
      ],
    ),
  );
}
