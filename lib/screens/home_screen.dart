import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  ///Corresponde a la pantalla principal donde se pueden ver varios articulos de la tienda
  ///no es necesario estar con una cuenta iniciada para poder ver esta pantalla
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      //resizeToAvoidBottomInset: false,
      appBar: appbarMethod(context),
      body: ListView.builder(
        itemBuilder: (_, index) => const CustomItemCard(),
        itemCount: 5,
      ),
    );
  }

  AppBar appbarMethod(BuildContext context) {
    return AppBar(
      title: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          width: 280,
          height: 40,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              //TODO cambiar la tipografia
              hintStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              prefixIcon: SvgPicture.asset(
                'assets/search.svg',
                height: 20,
              ), // AssetImage('assets/lupa.ico'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Busca un Producto',
            ),
          ),
        ),
      ),
      leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu_rounded),
              iconSize: 50,
              padding: const EdgeInsets.only(left: 10))),
      backgroundColor: const Color(0xffD6271F),
      elevation: 3,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          iconSize: 38,
          padding: const EdgeInsets.only(right: 12),
          onPressed: () {},
        ),
      ],
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
