import 'package:firebase_database/firebase_database.dart';
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
      {Key? key, required this.title, required this.query, required this.icon})
      : super(key: key);
  final String title;
  final Query query;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),

        ///Construción de la lista de categorias para mostrar en la pantalla.
        body: Column(
          children: [
            CategoryTitle(
              size: size,
              icon: icon,
              text: title,
            ),
            Flexible(
              child: FirebaseAnimatedList(

                  ///Resive la consulta de la base de datos.
                  query: query,
                  defaultChild: const CustomProgressIndicator(),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, snapshot, animation, index) {
                    if (!snapshot.exists) {
                      return NotificationsService.showErrorSnackbar(
                          'Ha ocurrido un error a la hora de cargar los datos.');
                    }
                    final category = Category.fromMap(
                        jsonDecode(jsonEncode(snapshot.value)));
                    return Column(
                      children: [
                        ListTile(
                            title: Text(
                              category.description
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  category.description
                                      .substring(1)
                                      .toLowerCase(),
                              style: CustomTextStyle.robotoMedium
                                  .copyWith(fontSize: 20),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: ColorStyle.mainRed,
                            ),
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => ProductsFilterScreen(
                                        category: category,
                                        icon: Icons.settings,
                                        title: category.description,
                                      ));
                              Navigator.push(context, route);
                            }),
                        const Divider(height: 5),
                      ],
                    );
                  }),
            ),
          ],
        ));
  }
}
