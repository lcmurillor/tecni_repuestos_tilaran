import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tecni Repuestos Tilarán',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          iconSize: 35,
        ),
        backgroundColor: Color(0xffD6271F),
        elevation: 3,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            iconSize: 35,
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Tecni Repuestos Tilarán'),
      ),
    );
  }
}
