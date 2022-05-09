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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),

      ///Construción de la lista de prodiuctos para la pantalla principal.
      body: StreamBuilder(
        ///Hace un llamdo a la base de datos y resive una lista de productos filtrado por el tipo
        ///(pude ser tanto un repuesto como un accesorio) y por la categoria especifica de cada uno.
        stream: FirebaseCloudService.getfilteredProducts(
            category.type, category.categoryName),

        ///Construye los objetos en base a lo resivido en la base de datos.
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasError) {
            return NotificationsService.showErrorSnackbar(
                'Ha ocurrido un error a la hora de cargar los datos.');
          }

          if (!snapshot.hasData) {
            return const CustomProgressIndicator();
          }

          final data = snapshot.data!;

          return Column(children: [
            CategoryTitle(
              size: size,
              icon: icon,
              text: title,
            ),
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                      title: data[index].description,
                      quantity: data[index].quantity,
                      total: data[index].total,
                      img: data[index].img);
                },
              ),
            )
          ]);
        },
      ),
    );
  }
}
