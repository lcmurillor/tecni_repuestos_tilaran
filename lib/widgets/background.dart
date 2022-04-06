import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(colors: [
    Color.fromRGBO(246, 18, 8, 1),
    Color.fromRGBO(216, 48, 41, 1),
  ]));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          containerHeightWidthBackground(size),
          Positioned(top: -45, left: 15, child: _LineBlacks1()),
          Positioned(top: -40, left: 250, child: _LineBlacks1()),
          Positioned(top: -40, right: -100, child: _LineBlacks1()),
          Container(
            width: double.infinity,
            height: 220,
            decoration: headerLogo(),
          ),
          child,
        ],
      ),
    );
  }

  BoxDecoration headerLogo() {
    return const BoxDecoration(
        image:
            DecorationImage(image: AssetImage('assets/logo.png'), scale: 0.80));
  }

  Container containerHeightWidthBackground(Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.42,
      decoration: boxDecoration,
    );
  }
}

class _LineBlacks1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / -6.5,
      child: Container(
          width: 106, height: 376, color: const Color.fromRGBO(209, 34, 27, 1)),
    );
  }
}
