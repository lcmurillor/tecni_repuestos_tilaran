import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Dentro del arreglo en este metodo se van instan2ciando e inicailiando
    ///los diferentes proveedores de servicios que la aplicacion necesite.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FirebaseProvider(),
          //Por defecto está en true pero ahora en folse si o si va a construir el objeto
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

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
