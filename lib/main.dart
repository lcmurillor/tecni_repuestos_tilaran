import 'package:flutter/material.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tecni repuestos Tilarán',
        theme: MainTheme.lightTheme,
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
        });
  }
}
