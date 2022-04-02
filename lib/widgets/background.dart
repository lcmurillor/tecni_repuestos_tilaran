import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final boxDecoration = BoxDecoration(color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 500,
          height: 350,
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
