import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/shared/preferences.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preferences.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode))
  ], child: const TecniRepuestoTilaran()));
}

class TecniRepuestoTilaran extends StatelessWidget {
  ///Widget principal que se encarga de la iniciación y construción del apartado visual
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
        locale: const Locale('cr'),
        debugShowCheckedModeBanner: false,
        title: 'Tecni repuestos Tilarán',
        theme: Provider.of<ThemeProvider>(context).currentTheme,
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
            }),
        routes: {
          'aboutUs': (_) => const AboutUsScreen(),
          'addresses': (_) => const UserAddressesScreen(),
          'editInformation': (_) => const UserInformationScreen(),
          'home': (_) => const HomeScreen(),
          'login': (_) => const LoginScreen(),
          'passwordChange': (_) => const UserPasswordScreen(),
          'passwordRequest': (_) => const PasswordRequestScreen(),
          'changePassword': (_) => const UserPasswordScreen(),
          'myOrders': (_) => const MyOrdersScreen(),
          'shipment': (_) => const ShipmentDetailScreen(),
          'register': (_) => const RegisterScreen(),
          'myCart': (_) => const MyCartScreen(),
          'profile': (_) => const UserProfileScreen(),
        });
  }
}
