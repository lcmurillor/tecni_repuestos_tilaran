import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/theme/app_theme.dart';

class ItemCard extends StatelessWidget {
  ///Contenedor que construye el card de producto con todo su contenido
  const ItemCard(
      {Key? key, required this.title, required this.total, required this.img})
      : super(key: key);
  final String title;
  final double total;
  final String img;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.52,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [MainTheme.cardShadow]),

        ///Construcción de los elementos dentro del contenedor
        child: Column(children: [
          productImage(size, img),
          productInfo(title),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ///Cambia la tipografía para que sea compatible con el signo de colones.
            Text(
              "₡${total.toStringAsFixed(0)}",
              style: TextStyle(
                  color: MainTheme.mainRed,
                  fontSize: 26,
                  fontWeight: FontWeight.w500),
            ),

            ///Este contenedor y todo lo que se encuentra dentro de el, corresponde
            ///al botón de agregar al carrito.
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: MainTheme.mainRed,
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  color: MainTheme.mainRed,
                ))
          ]),
          const SizedBox(height: 15)
        ]));
  }

  ///Éste médoto constuye la información que correspone al artículo.
  ListTile productInfo(String title) {
    return ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600)));
  }

  ///Éste método construye la imagen dentro del card de productos con todos los
  ///aspectos decorativos.
  Container productImage(Size size, String url) {
    ///Este conetendor disponde de un tamaño fijo para la imagen según el tamaño
    ///del disposito además esta parte del código contiene todos los elementos
    ///decorativos.
    return Container(
        width: double.infinity,
        height: size.height * 0.32,
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [MainTheme.cardShadow]),

        ///Este es el widget que se encarga de crear la imagen.
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: url.startsWith('http')
                ? FadeInImage(
                    placeholder:
                        const AssetImage('assets/placeholder-image.png'),
                    image: NetworkImage(url),
                    placeholderFit: BoxFit.cover,
                    fit: BoxFit.contain)
                : const Image(
                    image: AssetImage('assets/placeholder-image.png'),
                    fit: BoxFit.cover)));
  }
}
