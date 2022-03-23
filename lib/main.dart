import 'package:flutter/material.dart';
import 'package:tecni_repuestos/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tecni repuestos Tilarán',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomeScreen(),
        },
        home: HomeScreen());
  }
}
