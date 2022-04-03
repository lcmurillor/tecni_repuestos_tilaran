import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final boxDecoration = BoxDecoration(
      gradient: LinearGradient(colors: [
    Color.fromRGBO(246, 18, 8, 1),
    Color.fromRGBO(216, 48, 41, 1),
    //246 18 8 100
  ]));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.42,
          decoration: boxDecoration,
        ),
        Positioned(top: -45, left: 15, child: _LineBlacks1()),
        Positioned(top: -40, left: 250, child: _LineBlacks1()),
        Positioned(top: -40, right: -80, child: _LineBlacks1()),
      ],
    );
  }
}

class _LineBlacks1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / -6.5,
      child: Container(width: 90, height: 405, color: Colors.black26),
    );
  }
}
