import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class ProductsFilterScreen extends StatelessWidget {
  ///Éste widget permite mostrar una lista de artículos en lase a la categoria la cual
  ///es enviada como parámetro, cumple la misma función que la pantalala princial, muestra
  ///los cards de productos, solo que estos estan filtrados por la categoría.
  const ProductsFilterScreen(
      {Key? key,
      required this.title,
      required this.icon,
      required this.category})
      : super(key: key);
  final String title;
  final IconData icon;
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),

      ///Construción de la lista de productos para la pantalla de productos filtrados por categoría.
      body: FirebaseAnimatedList(
        ///Hace un llamado a la base de datos y resive una lista de productos filtrado por el tipo
        ///(pude ser tanto un repuesto como un accesorio) y por la categoría especifica de cada uno.
        query: FirebaseRealtimeService.getFilteredProducts(
            description: category.description),
        defaultChild: const CustomProgressIndicator(),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, snapshot, animation, index) {
          if (!snapshot.exists) {
            return NotificationsService.showErrorSnackbar(
                'Ha ocurrido un error a la hora de cargar los datos.');
          }
          final product =
              Product.fromMap(jsonDecode(jsonEncode(snapshot.value)));
          return FadeInLeft(child: ItemCard(product: product));
        },
      ),
    );
  }
}
