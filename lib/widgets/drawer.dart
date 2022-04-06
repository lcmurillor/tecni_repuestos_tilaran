// ignore_for_file: file_names

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/screens/screens.dart';

class CustomDrawer extends StatelessWidget {
  ///Éste widget corresponde al menú lateral desplegable que permite la navegación
  ///por la palicación.
  const CustomDrawer({Key? key}) : super(key: key);

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
              const LoginScreen(), context),
          moldeListile('Accesorios', Icons.sports_motorsports_outlined,
              const LoginScreen(), context),
          moldeListile('Inicia sesión', Icons.login_outlined,
              const LoginScreen(), context),
          moldeListile('Regístrate', Icons.person_add_outlined,
              const LoginScreen(), context),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
