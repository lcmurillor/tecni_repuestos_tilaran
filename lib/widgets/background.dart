import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool useImg;

  ///Es la imagen que se encuentra de fondo en multiples pantallas de la aplicación.
  ///dentro de esta se encuentras los elementos que conforman el diseño visual y recibe
  ///por parametros el widget el cual se espera construir ensima de este fondo y una indicación
  ///para saber si es nesario mostrar o no el logo de la empresa.
  const Background({Key? key, required this.child, required this.useImg})
      : super(key: key);
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(colors: [
    Color.fromRGBO(255, 11, 0, 1),
    Color.fromRGBO(216, 48, 41, 1),
  ], begin: Alignment.bottomLeft, end: Alignment.topRight));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      containerHeightWidthBackground(size),
      Positioned(top: -55, left: 15, child: _LineBlacks()),
      Positioned(top: -40, left: 230, child: _LineBlacks()),
      Positioned(top: -40, right: -110, child: _LineBlacks()),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          width: double.infinity,
          height: size.height * 0.3,
          child: useImg
              ? SvgPicture.asset(
                  'assets/logo-white.svg',
                  fit: BoxFit.contain,
                )
              : null),

      ///Corresponde al fondo gris claro que abarca toda la mitad inferir del fondo.
      Column(children: [
        Container(height: size.height * 0.42),
        Flexible(
          child: Container(
              color: const Color.fromRGBO(250, 250, 250, 1),
              width: double.infinity,
<<<<<<< HEAD
              height: size.height * 0.51),
=======
              height: size.height * 0.58),
>>>>>>> brach-luis
        )
      ]),
      child,
    ]);
  }

  ///Corresponde al fondo rojo con degradado de la parte superior del fondo.
  Container containerHeightWidthBackground(Size size) {
    return Container(
        width: double.infinity,
        height: size.height * 0.42,
        decoration: boxDecoration);
  }
}

///Define un tamaño y una rotación para los obejtos que decoran el fondo.
class _LineBlacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: -pi / -6.5,
        child: Container(
            width: 106,
            height: 500,
            color: const Color.fromRGBO(26, 26, 26, 0.10)));
  }
}
