import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  ///Corresponde a la pantalla principal donde se pueden ver varios articulos de la tienda
  ///no es necesario estar con una cuenta iniciada para poder ver esta pantalla.
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),

        ///Construción de la lista de articulos para la pantalla principal.
        body: StreamBuilder(
          ///Hace un llamado a la base de datos y resive una lista de productos.
          stream: FirebaseFirestoreService.getHomeProducts(),

          ///Construye los objetos en base a lo resivido en la base de datos.
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasError) {
              return NotificationsService.showErrorSnackbar(
                  'Ha ocurrido un error a la hora de cargar los datos.');
            }

            if (!snapshot.hasData) {
              return const CustomProgressIndicator();
            }

            final data = snapshot.data!;

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ItemCard(
                    title: data[index].description,
                    quantity: data[index].quantity,
                    total: data[index].total,
                    img: data[index].img);
              },
            );
          },
        ),
      ),
    );
  }
}
