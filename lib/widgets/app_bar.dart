import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/screens/placeholder_screen.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/search_delegate.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  ///Esta es la barra de menú superior con la herramienta de busqueda y que desplega el menú lateral.
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              width: 280,
              height: 35,
              child: TextField(
                  onTap: () {
                    showSearch(
                        context: context, delegate: ProductsSearchDelegate());
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: inputDecoration()))),
      leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(Icons.menu_rounded),
              iconSize: 45,
              padding: const EdgeInsets.only(left: 10))),
      backgroundColor: ColorStyle.mainRed,
      elevation: 3,
      actions: <Widget>[
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.shopping_cart),
          iconSize: 30,
          padding: const EdgeInsets.only(right: 12),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        const PlaceholderScreen(text: 'Carrito de compra')));
          },
        ),
      ],
    );
  }

  ///Éste método se encarga de la construcción del estilo de la barra de busqueda
  InputDecoration inputDecoration() {
    return InputDecoration(
        prefixStyle: GoogleFonts.roboto(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        hintText: 'Busca un Producto',
        hintStyle: GoogleFonts.roboto(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        prefixIcon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              'assets/search.svg',
              fit: BoxFit.contain,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
