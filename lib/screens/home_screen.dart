import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppbarMethod(),
        body: MethodListView(),
      ),
    );
  }

  ListView MethodListView() {
    return ListView(
      controller: _scrollController
        ..addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {}
        }),
      children: [
        CustomContainerCard(),
      ],
    );
  }

  Container CustomContainerCard() {
    return Container(
      height: 337,
      width: 346,
      margin: EdgeInsets.symmetric(vertical: 3.5, horizontal: 25),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ContainerCustomImageCard(),
              CustomInfoProduct("Titulo del artículo publicado",
                  "MisticFyah Burnidsajdsklsdbastic"),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("C99,500.00",
                          style: GoogleFonts.roboto(
                              color: Colors.red[700],
                              fontSize: 25,
                              fontWeight: FontWeight.w500)),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    Container(
                        child: IconButton(
                          alignment: Alignment.bottomRight,
                          icon: Image.asset(
                            'assets/carrito.ico',
                          ),
                          iconSize: 47,
                          onPressed: () {},
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12))
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container CustomInfoProduct(String titulo, String subtitulo) {
    return Container(
      child: ListTile(
        title: Text(titulo,
            style:
                GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w600)),
        subtitle: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            subtitulo,
            overflow: TextOverflow.visible,
            style: GoogleFonts.roboto(fontSize: 13),
            maxLines: 5,
          ),
        ),
      ),
    );
  }

  Container ContainerCustomImageCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        color: Color.fromARGB(106, 253, 253, 253),
        boxShadow: [
          new BoxShadow(
            color: Colors.black26,
            spreadRadius: -1,
            offset: new Offset(1, 3.0),
            blurRadius: 0.5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(106, 253, 253, 253),
            boxShadow: [
              new BoxShadow(
                color: Colors.black26,
                offset: new Offset(1, 3.0),
                blurRadius: 0.5,
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 2.0),
          child: FadeInImage(
            placeholder: NetworkImage('https://via.placeholder.com/315x189'),
            image: NetworkImage('https://via.placeholder.com/315x189'),
          ),

          // decoration: BoxDecoration(color: Colors.black),
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
