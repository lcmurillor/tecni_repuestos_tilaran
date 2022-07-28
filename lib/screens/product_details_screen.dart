import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';
import '../theme/themes.dart';
import 'screens.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formatCurrency = NumberFormat.currency(symbol: '₡');
    String tipo = product.type;
    if (product.type == 'spare') {
      tipo = 'Repuesto';
    } else {
      tipo = 'Accesorio';
    }
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: Scaffold(
            appBar: CustomAppBarBackArrow(
              editIcon: false,
              size: 41,
              icon: Icons.edit,
              iconColor1: Colors.black,
              actionIcon: Icons.delete_rounded,
              size1: 42,
              iconColor: Colors.red,
              onPressed: () {
                NotificationsService.displayDeleteDialog(
                  context,
                  'Está seguro que desea eliminar ${product.description}',
                  () {
                    FirebaseRealtimeService.deleteProduct(
                        productId: product.id);
                    Navigator.pop(context);
                    NotificationsService.showSnackbar('Producto eliminado');
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                );
              },
              navigatorOnPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductEditInformationScreen(product: product),
                  ),
                );
              },
            ),
            body: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (FirebaseAuthService.auth.currentUser != null) {
                      UserModel user =
                          await FirebaseRealtimeService.getUserByUid(
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
                  child: Container(
                    width: 300,
                    height: size.height * 0.25,
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
                              placeholder: const AssetImage(
                                  'assets/placeholder-image.png'),
                              image: NetworkImage(product.imageUrl),
                              placeholderFit: BoxFit.cover,
                              fit: BoxFit.contain)
                          : const Image(
                              image: AssetImage('assets/placeholder-image.png'),
                              fit: BoxFit.cover),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 300,
                  child: Text(
                    product.description,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 15,
                ),
                moldeRowInfo(
                  'Código: ',
                  product.code,
                  ColorStyle.mainBlue,
                ),
                const SizedBox(
                  height: 15,
                ),
                moldeRowInfo(
                  'Costo: ',
                  formatCurrency.format(product.cost),
                  ColorStyle.mainBlue,
                ),
                const SizedBox(
                  height: 15,
                ),
                moldeRowInfo(
                  'Localización: ',
                  product.location,
                  ColorStyle.mainRed,
                ),
                const SizedBox(
                  height: 15,
                ),
                moldeRowInfo(
                  'Categoría: ',
                  product.category,
                  ColorStyle.mainRed,
                ),
                const SizedBox(
                  height: 15,
                ),
                moldeRowInfo(
                  'Tipo: ',
                  tipo,
                  ColorStyle.mainRed,
                ),
                const SizedBox(
                  height: 15,
                ),
                moldeRowInfo(
                  'Precio: ',
                  formatCurrency.format(product.price),
                  ColorStyle.mainRed,
                ),
                const SizedBox(
                  height: 15,
                ),
                moldeRowInfo(
                  'Disponibles: ',
                  product.quantity.toString(),
                  ColorStyle.mainRed,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )),
      ),
    );
  }

  Padding moldeRowInfo(String text, [String text2 = '', Color? color2]) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(text,
                softWrap: true,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
          Expanded(
            child: Text(text2,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, color: color2)),
          ),
        ],
      ),
    );
  }
}
