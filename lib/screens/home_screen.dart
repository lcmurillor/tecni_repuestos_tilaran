import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatelessWidget {
  ///Corresponde a la pantalla principal donde se pueden ver varios articulos de la tienda
  ///no es necesario estar con una cuenta iniciada para poder ver esta pantalla.
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
<<<<<<< HEAD
        appBar: AppbarMethod(),
        body: const Center(
          child: Text('Tecni Repuestos Tilarán'),
=======
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
            return FadeInRight(
              child: CardProduct(product: product),
            );
          },
>>>>>>> 0dfb15e22d6feb1338d920a263bad5ed944cd89c
        ),
      ),
    );
  }

//
  AppBar AppbarMethod() {
    return AppBar(
      title: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        width: 250,
        height: 40,

        //   icon:Icon(Icons.search),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: 'Busca un Producto',
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
        iconSize: 37,
      ),
      backgroundColor: Color(0xffD6271F),
      elevation: 3,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          iconSize: 37,
          onPressed: () {},
        ),
      ],
    );
  }
}
