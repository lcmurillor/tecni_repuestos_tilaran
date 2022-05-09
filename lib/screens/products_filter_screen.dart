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
          final List<ItemCard> products = List<ItemCard>.generate(
              data.length,
              (index) => ItemCard(
                  title: data[index].description,
                  quantity: data[index].quantity,
                  total: data[index].total,
                  img: data[index].img));

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                  floating: true,
                  delegate: _SiverCustomHeaderDelegate(
                      minHeight: 50,
                      maxHeigth: 80,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: CategoryTitle(
                          size: size,
                          icon: icon,
                          text: title,
                        ),
                      ))),
              SliverList(delegate: SliverChildListDelegate([...products]))
            ],
          );
        },
      ),
    );
  }
}

class _SiverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SiverCustomHeaderDelegate(
      {required this.minHeight, required this.maxHeigth, required this.child});

  final double minHeight;
  final double maxHeigth;
  final Widget child;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeigth;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SiverCustomHeaderDelegate oldDelegate) {
    return maxHeigth != oldDelegate.maxHeigth ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
