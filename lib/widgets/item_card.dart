import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/theme/app_theme.dart';

class ItemCard extends StatelessWidget {
  ///Contenedor que construye el card de producto con todo su contenido
  const ItemCard({Key? key}) : super(key: key);

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
          productImage(size),
          productInfo("Título del artículo publicado",
              "Mollit Lorem adipisicing anim est excepteur aliqua nulla adipisicing commodo dolor qui occaecat pariatur.Mollit Lorem adipisicing anim est excepteur aliqua nulla adipisicing commodo dolor qui occaecat pariatur."),
          SizedBox(height: size.height * 0.02),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ///Cambia la tipografía para que sea compatible con el signo de colones.
            Text(
              "₡99,500.00",
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
          ])
        ]));
  }

  ///Éste médoto constuye la información que correspone al artículo.
  ListTile productInfo(String title, String subtitle) {
    return ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:
                GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w600)),
        subtitle: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(fontSize: 13),
              maxLines: 3,
            )));
  }

  ///Éste método construye la imagen dentro del card de productos con todos los
  ///aspectos decorativos.
  Container productImage(Size size) {
    ///Este conetendor disponde de un tamaño fijo para la imagen según el tamaño
    ///del disposito además esta parte del código contiene todos los elementos
    ///decorativos.
    return Container(
        width: double.infinity,
        height: size.height * 0.25,
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [MainTheme.cardShadow]),

        ///Este es el widget que se encarga de crear la imagen.
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const FadeInImage(
              placeholder: AssetImage('assets/placeholder-image.png'),
              image: NetworkImage('https://via.placeholder.com/350x200'),
              placeholderFit: BoxFit.cover,
              fit: BoxFit.cover),
        ));
  }
}
