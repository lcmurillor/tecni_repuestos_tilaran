import 'package:flutter/cupertino.dart';
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
          moldelListTile('Inicio', Icons.home, const HomeScreen(), context),
          moldelListTile(
              'Repuestos',
              Icons.settings,
              CategoryScreen(
                  stream: FirebaseCloudService.getSparesCategory(),
                  title: 'Repuestos',
                  icon: Icons.settings),
              context),
          moldelListTile(
              'Accesorios',
              Icons.sports_motorsports,
              CategoryScreen(
                  stream: FirebaseCloudService.getAccessoriesCategory(),
                  title: 'Repuestos',
                  icon: Icons.sports_motorsports),
              context),

          ///Pirmera condición para evaluar el estado de usuario. Si no se encuentra
          ///ningún usuario registrado en los archivos del dispositivo el menú solo
          ///va a mostrar loas funciones más basicas.
          if (FirebaseAuthService.auth.currentUser == null ||
              FirebaseAuthService.auth.currentUser!.isAnonymous) ...{
            moldelListTile('Inicia sesión', MdiIcons.arrowRightBox,
                const LoginScreen(), context),
            moldelListTile(
                'Regístrate', Icons.person_add, const RegisterScreen(), context)
          },

          ///Segunda condición para evaluar el estado de usuario. Si existe la instancia
          ///de un usario en la aplicación evaluará el rango de este usuario y ahora
          ///dispone de la opción de cerrar la sesión.
          if (FirebaseAuthService.auth.currentUser != null) ...{
            StreamBuilder(
              stream: FirebaseCloudService.getUser(
                  FirebaseAuthService.auth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                final data = snapshot.data!;

                ///Ultima condición para evaluar el estado de usuario. Si existe la instancia
                ///de un usario en la aplicación evaluará el rango de este usuario, si el usuario
                ///es administrador o vendedor, dispondrá de mas o menos opciones administrativas
                ///respetivamnete.
                return Column(children: [
                  if (data[0].administrator) ...[
                    moldelListTile(
                        'Administrar pedidos',
                        MdiIcons.archiveCog,
                        const PlaceholderScreen(text: 'Administrar pedidos'),
                        context),
                    moldelListTile(
                        'Administrar usuarios',
                        MdiIcons.accountCog,
                        const PlaceholderScreen(text: 'Adminitrar usuarios'),
                        context)
                  ] else if (data[0].vendor) ...[
                    moldelListTile(
                        'Administrar pedidos',
                        MdiIcons.archiveCog,
                        const PlaceholderScreen(text: 'Administrar pedidos'),
                        context),
                  ],
                  moldelListTile('Mi carrito', Icons.shopping_cart,
                      const PlaceholderScreen(text: 'Mi carrito'), context),
                  moldelListTile('Mis pedidos', MdiIcons.archive,
                      const PlaceholderScreen(text: 'Mis pedidos'), context),
                  moldelListTile('Mi perfil', MdiIcons.account,
                      const PlaceholderScreen(text: 'Mi perfil'), context),
                  moldelListTile(
                      'Cerrar sesión', MdiIcons.arrowLeftBox, null, context),
                ]);
              },
            ),
          },
          moldelListTile(
              'Acerca de', Icons.info, const AboutUsScreen(), context),
        ],
      )),
    );
  }

  ///Método que construye los elementos listados del menú lateral.
  ListTile moldelListTile(
    String title,
    IconData icon,
    Widget? page,
    BuildContext context,
  ) {
    return ListTile(
      title: Text(title,
          style: CustomTextStyle.robotoSemiBold.copyWith(fontSize: 20)),
      leading: Icon(icon, color: Colors.black, size: 35),
      onTap: () {
        if (page != null) {
          Route route = CupertinoPageRoute(builder: (context) => page);
          Navigator.push(context, route);
        } else {
          FirebaseAuthService.signOut(context);
        }
      },
    );
  }
}
