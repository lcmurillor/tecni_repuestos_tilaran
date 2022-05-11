import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarBackArrow(
        actionIcon: Icons.dark_mode,
        onPressed: () {},
        navigatorOnPressed: () => Navigator.pushNamed(context, 'home'),
      ),
      body: StreamBuilder(
        stream: FirebaseCloudService.getUserByUid(
            FirebaseAuthService.auth.currentUser!.uid),
        builder:
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
                child: CircleAvatar(
                  child: Text(
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
                  style: CustomTextStyle.robotoExtraBold
                      .copyWith(fontSize: 20, color: Colors.black)),
              const SizedBox(
                height: 7,
              ),
              Text(user[0].email,
                  style: CustomTextStyle.robotoSemiBold
                      .copyWith(fontSize: 15, color: ColorStyle.textGrey)),
              const SizedBox(
                height: 7,
              ),
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
                // faicon: FontAwesomeIcons.chevronRight,
                onPressed: () {},
                text: 'Editar mi información',
              ),
              InfoButton(
                //   faicon: FontAwesomeIcons.chevronRight,
                icon: MdiIcons.formTextboxPassword,
                onPressed: () {},
                text: 'Cambiar mi contraseña',
              ),
              InfoButton(
                //  faicon: FontAwesomeIcons.chevronRight,
                icon: MdiIcons.mapPlus,
                onPressed: () {
                  Navigator.pushNamed(context, 'addresses');
                },
                text: 'Gestionar Dirrecciones',
              ),
            ],
          );
        },
      ),
    );
  }
}
