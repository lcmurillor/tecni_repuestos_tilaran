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
      title: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          width: 290,
          height: 40,

          //   icon:Icon(Icons.search),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              prefixIcon: Image.asset(
                  'assets/lupa22.ico'), // AssetImage('assets/lupa.ico'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Busca un Producto',
            ),
          ),
        ),
      ),
      leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu_rounded),
          iconSize: 50,
          padding: EdgeInsets.only(left: 12)),
      backgroundColor: Color(0xffD6271F),
      elevation: 3,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          iconSize: 38,
          padding: EdgeInsets.only(right: 12),
          onPressed: () {},
        ),
      ],
    );
  }
}
