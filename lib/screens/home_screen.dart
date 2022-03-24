import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  ///Corresponde a la pantalla principal donde se pueden ver varios articulos de la tienda
  ///no es necesario estar con una cuenta iniciada para poder ver esta pantalla
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: ListView.builder(
        itemBuilder: (_, index) => const CustomItemCard(),
        itemCount: 10,
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Drawer.png'), fit: BoxFit.cover)),
          ),
        ),
        moldeListile('Inicio', Icons.home, Colors.black),
        moldeListile('Repuestos', Icons.settings, Colors.black),
        moldeListile(
            'Accesorios', Icons.sports_motorsports_rounded, Colors.black),
        moldeListile('Inicia sesión', Icons.login_rounded, Colors.black),
        moldeListile('Regístrate', Icons.person_add, Colors.black),
        moldeListile('Acerca de', Icons.info, Colors.black),
      ],
    ));
  }

  //sub proceso de ListTile dado que se repetía muchas veces lo mismo
  ListTile moldeListile(String titulo, IconData icono, Color color) {
    return ListTile(
      title: Text(titulo,
          style:
              GoogleFonts.roboto(fontSize: 16.68, fontWeight: FontWeight.w600)),
      leading: Icon(icono, color: color, size: 35),
      onTap: () {},
    );
  }
}
