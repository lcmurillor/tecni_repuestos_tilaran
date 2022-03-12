import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppbarMethod(),
          body: ListView(
            children: [
              Container(
                height: 337,
                width: 346,
                margin: EdgeInsets.symmetric(vertical: 3.5, horizontal: 15),
                child: Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 2.0),
                            child: FadeInImage(
                              placeholder: NetworkImage(
                                  'https://via.placeholder.com/315x189'),
                              image: NetworkImage(
                                  'https://via.placeholder.com/315x189'),
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(232, 253, 253, 253),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black54,
                                  offset: new Offset(0.0, 4.0),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            // decoration: BoxDecoration(color: Colors.black),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            leading: Icon(Icons.arrow_back_ios_new_outlined),
                            title: Text("Texto 1"),
                            subtitle: Text("Texto 2"),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              child: Text("Hola"),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          )),
    );
  }

//
  AppBar AppbarMethod() {
    return AppBar(
      title: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          width: 280,
          height: 40,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
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
          padding: EdgeInsets.only(left: 10)),
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
