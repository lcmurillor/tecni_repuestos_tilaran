import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/theme/app_theme.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TecniRepuestoTilaran());
}

// class AppState extends StatelessWidget {
//   const AppState({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ///Dentro del arreglo en este metodo se van instan2ciando e inicailiando
//     ///los diferentes proveedores de servicios que la aplicacion necesite.
//     return MultiProvider(
//       providers: const [],
//       child: const TecniRepuestoTilaran(),
//     );
//   }
// }

class TecniRepuestoTilaran extends StatelessWidget {
  ///Widget principal que se encarga de la inicación y contrución del apartado visual
  ///de la aplicación.
  const TecniRepuestoTilaran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('es', 'ES'),
          Locale('en', 'US'),
        ],
        locale: const Locale('zh'),
        debugShowCheckedModeBanner: false,
        title: 'Tecni repuestos Tilarán',
        theme: MainTheme.lightTheme,
        scaffoldMessengerKey: NotificationsService.messengerKey,

        ///Evalúa las diferentes condiciones de los datos en la aplicación, si está
        ///cargando, si a ocurrido un error, si hay un usario registrado o ninguna de las anteriores.
        ///Según el caso, ejecutará una acción u otra.
        home: StreamBuilder(
          stream: FirebaseAuthService.auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomProgressIndicator();
            } else if (snapshot.hasError) {
              ///Hace un llamado al "LoginScreen" pero debe indicar el error que ha occurrido.
              return const LoginScreen(hasError: true);
            } else if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
        // initialRoute: 'login',
        ///Estas rutas NO SE PUEDEN BORRAR , ya que son utiliazadas en otras pantallas
        ///para hacer la navegación.
        routes: {
          'aboutUs': (_) => const AboutUsScreen(),
          'home': (_) => const HomeScreen(),
          'login': (_) => const LoginScreen(),
          'register': (_) => const RegisterScreen(),
          'passwordRequest': (_) => const PasswordRequestScreen()
        });
  }
}
