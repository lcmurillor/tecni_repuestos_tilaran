import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppbarMethod(),
        body: const Center(
          child: Text('Tecni Repuestos Tilarán'),
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
