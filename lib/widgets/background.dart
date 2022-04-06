import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(colors: [
    Color.fromRGBO(255, 11, 0, 1),
    Color.fromRGBO(216, 48, 41, 1),
  ], begin: Alignment.bottomLeft, end: Alignment.topRight));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        containerHeightWidthBackground(size),
        Positioned(top: -55, left: 15, child: _LineBlacks()),
        Positioned(top: -40, left: 230, child: _LineBlacks()),
        Positioned(top: -40, right: -110, child: _LineBlacks()),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          width: double.infinity,
          height: size.height * 0.3,
          child: SvgPicture.asset(
            'assets/logo-white.svg',
            fit: BoxFit.contain,
          ),
        ),
        child,
      ],
    );
  }

  Container containerHeightWidthBackground(Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.42,
      decoration: boxDecoration,
    );
  }
}

class _LineBlacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / -6.5,
      child: Container(
          width: 106, height: 500, color: const Color.fromRGBO(26, 26, 26, 1)),
    );
  }
}
