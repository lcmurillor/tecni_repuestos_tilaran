import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class CategoryScreen extends StatelessWidget {
  ///Es una pantalla intermedia en la cual el usuario puede especificar la categoría de repuesto
  ///o accesorio que está buscando. Seguidamente despegará una pantalla donde se muestre una lista de
  ///productos que corespondan a la categoria que a especificado.
  const CategoryScreen(
      {Key? key, required this.title, required this.icon, required this.type})
      : super(key: key);
  final String title;
  final String type;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: const CustomAppBar(),
          drawer: const CustomDrawer(),

          ///Construción de la lista de categorias para mostar en la pantalla.
          body: FutureBuilder(

              ///Hace un llamado a la base de datos y recibe una lista de categorias.
              future: FirebaseRealtimeService.getCategories(type: type),

              ///Construye los objetos en base a lo recibido en la base de datos.
              builder: (BuildContext context,
                  AsyncSnapshot<List<Category>> snapshot) {
                if (snapshot.hasError) {
                  return NotificationsService.showErrorSnackbar(
                      'Ha ocurrido un error a la hora de cargar los datos.');
                }

                if (!snapshot.hasData) {
                  return const CustomProgressIndicator();
                }

                final data = snapshot.data!;

                ///Ordena el arreglo de datos alfabéticamente.
                final orderData = data
                  ..sort((a, b) => a.description.compareTo(b.description));

                return Column(children: [
                  ///Construye el encabezado con el título de las categorías.
                  CategoryTitle(size: size, icon: icon, text: title),

                  ///Construye la lista de categorías.
                  Flexible(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: orderData.length,
                        itemBuilder: (context, index) => ListTile(
                            title: Text(
                              orderData[index]
                                      .description
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  orderData[index]
                                      .description
                                      .substring(1)
                                      .toLowerCase(),
                              style: CustomTextStyle.robotoMedium
                                  .copyWith(fontSize: 18),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: ColorStyle.mainRed,
                            ),
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => ProductsFilterScreen(
                                      category: orderData[index],
                                      icon: icon,
                                      title: orderData[index]
                                              .description
                                              .substring(0, 1)
                                              .toUpperCase() +
                                          orderData[index]
                                              .description
                                              .substring(1)
                                              .toLowerCase()));
                              Navigator.push(context, route);
                            }),
                        separatorBuilder: (_, __) => const Divider()),
                  )
                ]);
              })),
    );
  }
}
