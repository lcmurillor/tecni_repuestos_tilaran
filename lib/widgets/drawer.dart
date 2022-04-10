// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/screens/screens.dart';

class CustomDrawer extends StatelessWidget {
  ///Éste widget corresponde al menú lateral desplegable que permite la navegación
  ///por la palicación.
  const CustomDrawer({Key? key}) : super(key: key);
  final String user = 'admin';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: ListView(
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
          moldeListile(
              'Inicio', Icons.home_outlined, const HomeScreen(), context),
          moldeListile('Repuestos', Icons.settings_outlined,
              const CategorySparesScreen(), context),
          moldeListile('Accesorios', Icons.sports_motorsports_outlined,
              const CategoryAccessoriesScreen(), context),

          ///Ésta condición permite agregar más elementos a la lista dem nenú latera si se cumple
          ///la condición.
          if (user == 'user' || user == 'admin') ...{
            moldeListile(
                'Mi carrito', Icons.home_outlined, const HomeScreen(), context),
            moldeListile('Mis Pedidos', Icons.home_outlined, const HomeScreen(),
                context),
          },
          if (user == 'admin') ...{
            moldeListile('Administrar pedidos', MdiIcons.archiveCogOutline,
                const HomeScreen(), context),
            moldeListile('Administrar usuarios', MdiIcons.accountCogOutline,
                const HomeScreen(), context),
            moldeListile('Mi perfil', MdiIcons.accountOutline,
                const HomeScreen(), context),
            moldeListile('Cerrar sesión', Icons.home_outlined,
                const HomeScreen(), context),
          },
          moldeListile('Inicia sesión', Icons.login_outlined,
              const LoginScreen(), context),
          moldeListile('Regístrate', Icons.person_add_outlined,
              const RegisterScreen(), context),
          moldeListile(
              'Acerca de', Icons.info_outline, const AboutUsScreen(), context),
        ],
      )),
    );
  }

  ///Método que construye los elementos listados del menú lateral.
  ListTile moldeListile(
    String title,
    IconData icon,
    Widget page,
    BuildContext context,
  ) {
    return ListTile(
      title: Text(title,
          style:
              GoogleFonts.roboto(fontSize: 16.68, fontWeight: FontWeight.w600)),
      leading: Icon(icon, color: Colors.black, size: 35),
      onTap: () {
        Route route = CupertinoPageRoute(builder: (context) => page);
        Navigator.push(context, route);
      },
    );
  }
}
