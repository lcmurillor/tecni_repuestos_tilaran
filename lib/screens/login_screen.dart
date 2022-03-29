import 'package:flutter/material.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Text('Hola'),
    );
  }
}
