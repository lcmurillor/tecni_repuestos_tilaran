import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teni Repuestos Tilarán',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Teni Repuestos Tilarán'),
        ),
        body: const Center(
          child: Text('Teni Repuestos Tilarán'),
        ),
      ),
    );
  }
}
