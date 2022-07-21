import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class CardItem extends StatelessWidget {
  ///Contenedor que construye el card de producto con todo su contenido.
  const CardItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formatCurrency = NumberFormat.currency(symbol: "₡ ");
    return Card(

        ///Construcción de los elementos dentro del contenedor.
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        productImage(size),
        productInfo(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ///Cambia la tipografía para que sea compatible con el signo de colones.
          Text(
            formatCurrency.format(product.price),
            style: TextStyle(
                color: ColorStyle.mainRed,
                fontSize: 26,
                fontWeight: FontWeight.w500),
          ),

          ///Este contenedor y todo lo que se encuentra dentro de el, corresponde
          ///al botón de agregar al carrito.
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: ColorStyle.mainRed,
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 30.0,
                ),
                color: ColorStyle.mainRed,
              ))
        ])
      ]),
    ));
  }

  ///Éste médoto constuye la información que correspone al artículo.
  ListTile productInfo() {
    return ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(product.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: CustomTextStyle.robotoSemiBold.copyWith(fontSize: 18)),
        subtitle: Text('Disponibles: ${product.quantity}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:
                GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w600)));
  }

  ///Éste método construye la imagen dentro del card de productos con todos los
  ///aspectos decorativos.
  GestureDetector productImage(Size size) {
    ///Al precionar por sobre ina imagen, ya sea vacía o una imagen de producto.
    ///permite abrir la galería y seleccionar una imagen para el respectivo producto.
    ///Evaúa que solo los administradores pedan cambiar la imagen.
    return GestureDetector(
      onTap: () async {
        if (FirebaseAuthService.auth.currentUser != null) {
          UserModel user = await FirebaseRealtimeService.getUserByUid(
              uid: FirebaseAuthService.auth.currentUser!.uid);
          if (user.administrator) {
            final result = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.custom,
                allowedExtensions: ['png', 'jpg']);
            if (result == null) {
              NotificationsService.showSnackbar(
                  'No ha selecionado ninguna imagen.');
            } else {
              final path = result.files.single.path;
              final name = product.id;
              FirebaseStorageService.uploadProductFile(path!, name);
            }
          }
        }
      },

      ///Este contendor disponde de un tamaño fijo para la imagen según el tamaño
      ///del disposito además esta parte del código contiene todos los elementos
      ///decorativos.
      child: Container(
          width: double.infinity,
          height: size.height * 0.30,
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [MainTheme.cardShadow]),

          ///Este es el widget que se encarga de crear la imagen.
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: product.imageUrl.startsWith('http')
                  ? FadeInImage(
                      placeholder:
                          const AssetImage('assets/placeholder-image.png'),
                      image: NetworkImage(product.imageUrl),
                      placeholderFit: BoxFit.cover,
                      fit: BoxFit.contain)
                  : const Image(
                      image: AssetImage('assets/placeholder-image.png'),
                      fit: BoxFit.cover))),
    );
  }
}
