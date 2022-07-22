import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
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
                //TODO: Realizar la funcion para vaciar el carrito.
              },
              navigatorOnPressed: () => Navigator.pop(context),
            ),
            body: Column(
              children: [
                Text(product.description),
                Text(product.id),
                Text(product.code),
                Text(product.imageUrl),
                product.imageUrl.startsWith('http')
                    ? FadeInImage(
                        placeholder:
                            const AssetImage('assets/placeholder-image.png'),
                        image: NetworkImage(product.imageUrl),
                        placeholderFit: BoxFit.cover,
                        fit: BoxFit.contain)
                    : const Image(
                        image: AssetImage('assets/placeholder-image.png'),
                        fit: BoxFit.cover),
              ],
            )),
      ),
    );
  }
}
