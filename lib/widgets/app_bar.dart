
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      LocalDataService.getCartCount()
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
          isLabelVisible: count.getCount() > 0,
          label: IgnorePointer(child: Text('${count.getCount()}')),
          backgroundColor: ColorStyle.mainGreen,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.shopping_cart),
            iconSize: 30,
            padding: const EdgeInsets.only(right: 12),
            onPressed: () {
              if (DemoAuthService.auth.currentUser == null ||
                  DemoAuthService.auth.currentUser!.isAnonymous) {
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
        prefixStyle: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        hintText: 'Busca un Producto',
        hintStyle: TextStyle(
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
