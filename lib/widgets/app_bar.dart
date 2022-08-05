import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/search_delegate.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  ///Esta es la barra de menú superior con la herramienta de busqueda y que desplega el menú lateral.
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    final count = Provider.of<MyCartInfoProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      FirebaseRealtimeService.getCartCount()
          .then((value) => count.setCount(count: value));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<MyCartInfoProvider>(context);
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
        Badge(
          elevation: 0,
          showBadge: (count.getCount() > 0),
          badgeContent: Text(
            '${count.getCount()}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
          badgeColor: ColorStyle.mainGreen,
          position: BadgePosition.topStart(top: 0, start: 0),
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.shopping_cart),
            iconSize: 30,
            padding: const EdgeInsets.only(right: 12),
            onPressed: () {
              if (FirebaseAuthService.auth.currentUser == null ||
                  FirebaseAuthService.auth.currentUser!.isAnonymous) {
                NotificationsService.showSnackbar(
                    'Inicia sesión para disponer de las funciones de carrito de compras.');
              } else {
                Navigator.pushNamed(context, 'myCart');
              }
            },
          ),
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
}
