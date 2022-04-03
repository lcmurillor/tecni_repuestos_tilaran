// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

import '../theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Background(),
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logo.png'), scale: 0.80)),
          ),
          CardLogin()
        ],
      )),
    );
  }
}
