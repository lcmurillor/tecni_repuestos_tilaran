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
      {Key? key, required this.title, required this.stream, required this.icon})
      : super(key: key);
  final String title;
  final Stream<List<Category>> stream;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),

        ///Construción de la lista de categorias para mostar en la pantalla.
        body: StreamBuilder(

            ///Hace un llamado a la base de datos y resive una lista de categorias.
            stream: stream,

            ///Construye los objetos en base a lo resivido en la base de datos.
            builder:
                (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
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
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) => ListTile(
                          title: Text(
                            data[index].categoryLabel,
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
                                      category: data[index],
                                      icon: Icons.settings,
                                      title: data[index].categoryLabel,
                                    ));
                            Navigator.push(context, route);
                          }),
                      separatorBuilder: (_, __) => const Divider()),
                )
              ]);
            }));
  }
}
