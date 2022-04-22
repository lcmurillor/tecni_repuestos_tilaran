import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTitle extends StatelessWidget {
  ///Ésteme método se encarga de construir en la parte superior un encabesado con un icono
  ///y un texto en grande para hacerle saber al usario siempre que typo de categoria estamos viendo.
  ///ya sea la categoria de accesorios o la categoria de repuestos.
  const CategoryTitle(
      {Key? key, required this.size, required this.text, required this.icon})
      : super(key: key);

  final Size size;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:
            (size.height - Scaffold.of(context).appBarMaxHeight!.toDouble()) *
                0.10,
        width: double.infinity,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 40),
          const SizedBox(width: 10),
          Text(text,
              style:
                  GoogleFonts.roboto(fontSize: 40, fontWeight: FontWeight.w500))
        ]));
  }
}
