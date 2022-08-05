import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

class AdminUserProfileScreen extends StatelessWidget {
  const AdminUserProfileScreen({Key? key, required this.user})
      : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarBackArrow(
          onPressed: () {},
          navigatorOnPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminUsersScreen(),
              ),
            );
          },
        ),
        body: FirebaseAnimatedList(
          query: FirebaseRealtimeService.getUserQueryByUid(
              uid: FirebaseAuthService.auth.currentUser!.uid),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, snapshot, animation, index) {
            if (!snapshot.exists) {
              return NotificationsService.showErrorSnackbar(
                  'Ha ocurrido un error a la hora de cargar los datos.');
            }
            //  final user = User.fromMap(jsonDecode(jsonEncode(snapshot.value)));
            return Column(
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      CircleAvatar(
                          child: user.profileImg.startsWith('http')
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/placeholder-user.png'),
                                      image: NetworkImage(user.profileImg),
                                      placeholderFit: BoxFit.cover,
                                      fit: BoxFit.contain),
                                )
                              : Text(
                                  user.name.substring(0, 1).toUpperCase() +
                                      '' +
                                      user.lastname
                                          .substring(0, 1)
                                          .toUpperCase(),
                                  style: CustomTextStyle.robotoMedium.copyWith(
                                      fontSize: 50, color: Colors.white),
                                ),
                          backgroundColor: ColorStyle.mainGrey,
                          maxRadius: 58),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                    user.name.toUpperCase() + ' ' + user.lastname.toUpperCase(),
                    style:
                        CustomTextStyle.robotoExtraBold.copyWith(fontSize: 20)),
                const SizedBox(height: 7),
                Text(user.email,
                    style: CustomTextStyle.robotoSemiBold
                        .copyWith(fontSize: 15, color: ColorStyle.textGrey)),
                const SizedBox(height: 7),
                Text('+506 ' + user.phone,
                    style: CustomTextStyle.robotoSemiBold
                        .copyWith(fontSize: 16, color: ColorStyle.mainRed)),
                const SizedBox(height: 7),
                Text(
                    DateFormat('dd-MM-yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(user.birthdate)),
                    style: CustomTextStyle.robotoExtraBold
                        .copyWith(fontSize: 15, color: ColorStyle.textGrey)),
                const SizedBox(height: 20),
                InfoButton(
                    icon: MdiIcons.accountEdit,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminUsersOrdersScreens(
                            user: user,
                          ),
                        ),
                      );
                    },
                    text: 'Gestionar Pedidos'),
                InfoButton(
                    icon: MdiIcons.formTextboxPassword,
                    onPressed: () {
                      DialogSelectRol.displaySelectRol(
                          context: context, user: user);
                    },
                    text: 'Cambiar rol del usuario'),
                InfoButton(
                    icon: MdiIcons.mapPlus,
                    onPressed: () {
                      NotificationsService.displayDeleteDialog(
                          context: context,
                          text:
                              'Está seguro que desea eliminar a ${user.name + ' ' + user.lastname}',
                          onPressed: () {
                            FirebaseRealtimeService.deleteUser(id: user.id);
                            NotificationsService.showSnackbar(
                                'Usuario eliminado');
                            Navigator.canPop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdminUsersScreen(),
                              ),
                            );
                          });
                    },
                    text: 'Eliminar usuario'),
              ],
            );
          },
        ),
      ),
    );
  }
}
