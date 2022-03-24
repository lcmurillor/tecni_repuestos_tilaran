// ignore_for_file: file_names

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

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
                      image: AssetImage('assets/Drawer.png'),
                      fit: BoxFit.cover)),
            ),
          ),
          moldeListile('Inicio', Icons.home_outlined),
          moldeListile('Repuestos', Icons.settings_outlined),
          moldeListile('Accesorios', Icons.sports_motorsports_outlined),
          moldeListile('Inicia sesión', Icons.login_outlined),
          moldeListile('Regístrate', Icons.person_add_outlined),
          moldeListile('Acerca de', Icons.info_outline),
        ],
      )),
    );
  }

  ///Método que construye los elementos listados del menú lateral.
  ListTile moldeListile(
    String titulo,
    IconData icono,
  ) {
    return ListTile(
      title: Text(titulo,
          style:
              GoogleFonts.roboto(fontSize: 16.68, fontWeight: FontWeight.w600)),
      leading: Icon(icono, color: Colors.black, size: 35),
      onTap: () {},
    );
  }
}
