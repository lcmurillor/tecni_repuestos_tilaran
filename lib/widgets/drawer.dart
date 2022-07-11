import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class CustomDrawer extends StatelessWidget {
  ///Éste widget corresponde al menú lateral desplegable que permite la navegación
  ///por la palicación.
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/logo-drawer.png'),
                      fit: BoxFit.cover)),
            ),
          ),
          _moldelListTile('Inicio', Icons.home, const HomeScreen(), context),
          _moldelListTile(
              'Repuestos',
              Icons.settings,
              CategoryScreen(
                  stream: FirebaseFirestoreService.getSparesCategory(),
                  title: 'Repuestos',
                  icon: Icons.settings),
              context),
          _moldelListTile(
              'Accesorios',
              Icons.sports_motorsports,
              CategoryScreen(
                  stream: FirebaseFirestoreService.getAccessoriesCategory(),
                  title: 'Accesorios',
                  icon: Icons.sports_motorsports),
              context),

          ///Pirmera condición para evaluar el estado de usuario. Si no se encuentra
          ///ningún usuario registrado en los archivos del dispositivo el menú solo
          ///va a mostrar loas funciones más basicas.
          if (FirebaseAuthService.auth.currentUser == null ||
              FirebaseAuthService.auth.currentUser!.isAnonymous) ...{
            _moldelListTile('Inicia sesión', MdiIcons.arrowRightBox,
                const LoginScreen(), context),
            _moldelListTile(
                'Regístrate', Icons.person_add, const RegisterScreen(), context)
          },

          ///Segunda condición para evaluar el estado de usuario. Si existe la instancia
          ///de un usario en la aplicación evaluará el rango de este usuario y ahora
          ///dispone de la opción de cerrar la sesión.
          if (FirebaseAuthService.auth.currentUser != null) ...{
            StreamBuilder(
              stream: FirebaseFirestoreService.getUserByUid(
                  FirebaseAuthService.auth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.hasError) {
                  NotificationsService.showErrorSnackbar(
                      'Ha ocurrido un error con la carga de los datos.');
                }

                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                final data = snapshot.data!;

                ///Última condición para evaluar el estado de usuario. Si existe la instancia
                ///de un usario en la aplicación evaluará el rango de este usuario, si el usuario
                ///es administrador o vendedor, dispondrá de mas o menos opciones administrativas
                ///respetivamnete.
                return Column(children: [
                  if (data[0].administrator) ...[
                    _moldelListTile(
                        'Administrar pedidos',
                        MdiIcons.archiveCog,
                        const PlaceholderScreen(text: 'Administrar pedidos'),
                        context),
                    _moldelListTile(
                        'Administrar usuarios',
                        MdiIcons.accountCog,
                        const PlaceholderScreen(text: 'Adminitrar usuarios'),
                        context)
                  ] else if (data[0].vendor) ...[
                    _moldelListTile(
                        'Administrar pedidos',
                        MdiIcons.archiveCog,
                        const PlaceholderScreen(text: 'Administrar pedidos'),
                        context),
                  ],
                  _moldelListTile('Mi carrito', Icons.shopping_cart,
                      const MyCartScreen(), context),
                  _moldelListTile('Mis pedidos', MdiIcons.archive,
                      const MyPackegesScreen(), context),
                  _moldelListTile('Mi perfil', MdiIcons.account,
                      const UserProfileScreen(), context),
                  _moldelListTile(
                      'Cerrar sesión', MdiIcons.arrowLeftBox, null, context),
                ]);
              },
            ),
          },
          _moldelListTile(
              'Acerca de', Icons.info, const AboutUsScreen(), context),
        ],
      )),
    );
  }
}

///Método que construye los elementos listados del menú lateral.
ListTile _moldelListTile(
  String title,
  IconData icon,
  Widget? page,
  BuildContext context,
) {
  return ListTile(
    title: Text(title,
        style: CustomTextStyle.robotoSemiBold.copyWith(fontSize: 20)),
    leading: Icon(icon, size: 35),
    onTap: () {
      if (page != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      } else {
        FirebaseAuthService.signOut(context);
      }
    },
  );
}
