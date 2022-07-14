import 'package:firebase_database/ui/firebase_animated_list.dart';
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
            body: FirebaseAnimatedList(
              ///Resive la consulta de la base de datos.
              query: FirebaseRealtimeService.getHomeProducts(),
              defaultChild: const CustomProgressIndicator(),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, snapshot, animation, index) {
                if (!snapshot.exists) {
                  return NotificationsService.showErrorSnackbar(
                      'Ha ocurrido un error a la hora de cargar los datos.');
                }
                final product =
                    Product.fromMap(jsonDecode(jsonEncode(snapshot.value)));
                return ItemCard(
                    title: product.description,
                    total: product.price,
                    img: product.imageUrl,
                    quantity: product.quantity);
              },
            )));
  }
}
