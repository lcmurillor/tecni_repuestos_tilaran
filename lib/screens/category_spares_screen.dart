import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class CategorySparesScreen extends StatelessWidget {
  ///Es una pantalla intermedia en la cual el usario puede especificar la categoría de repuesto
  ///que está buscando. Seguidamente mostrarle una pantalla donde se muestre una lista de
  ///productos que corespondan a la categoria que a especificado.
  const CategorySparesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),

        ///Construción de la lista de categorias para mostar en la pantalla de repuestos.
        body: StreamBuilder(

            ///Hace un llamdo a la base de datos y resive una lista de categorias.
            stream: FirebaseCloudService.getSparesCategory(),

            ///Construye los objetos en base a lo resivido en la base de datos.
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                    child:
                        CircularProgressIndicator(color: ColorStyle.mainRed));
              }

              final data = snapshot.data;

              return Column(children: [
                CategoryTitle(
                  size: size,
                  icon: Icons.settings,
                  text: 'Repuestos',
                ),
                Flexible(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) => ListTile(
                            title: Text(
                              data[index].categoryLabel,
                              style: GoogleFonts.roboto(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: ColorStyle.mainRed,
                            ),
                            onTap: () {
                              Route route = CupertinoPageRoute(
                                  builder: (context) => ProductsFilterScreen(
                                        category: data[index],
                                        icon: Icons.settings,
                                        title: data[index].categoryLabel,
                                      ));
                              Navigator.push(context, route);
                            },
                          ),
                      separatorBuilder: (_, __) => const Divider()),
                )
              ]);
            }));
  }
}
