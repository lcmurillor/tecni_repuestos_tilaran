// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/shared/preferences.dart';
import 'package:tecni_repuestos/screens/demo_access_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // Backend original fuera de servicio.
  await Preferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode),
        ),
        ChangeNotifierProvider(create: (_) => MyCartInfoProvider()),
        ChangeNotifierProvider(create: (_) => ComeFromProvider()),
      ],
      child: const TecniRepuestoTilaran(),
    ),
  );
}

class TecniRepuestoTilaran extends StatelessWidget {
  ///Widget principal que se encarga de la iniciación y construción del apartado visual
  ///de la aplicación.
  const TecniRepuestoTilaran({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US')],
      locale: const Locale('es', 'ES'),
      debugShowCheckedModeBanner: false,
      title: 'Tecni repuestos Tilarán',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      scaffoldMessengerKey: NotificationsService.messengerKey,

      ///Evalúa las diferentes condiciones de los datos en la aplicación, si está
      ///cargando, si a ocurrido un error, si hay un usario registrado o ninguna de las anteriores.
      ///Según el caso, ejecutará una acción u otra.
      builder: (context, child) => Center(
        child: SizedBox(
          width: 480,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Material(
                color: const Color(0xFF152536),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'PROTOTIPO · Datos ficticios · Sin compras reales',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(size: constraints.biggest),
                    child: child!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      home: const HomeScreen(),
      routes: {
        'aboutUs': (_) => const AboutUsScreen(),
        'addresses': (_) => const UserAddressesScreen(),
        'editInformation': (_) => const UserInformationScreen(),
        'home': (_) => const HomeScreen(),
        'login': (_) => const DemoAccessScreen(),
        'passwordChange': (_) => const DemoAccessScreen(),
        'passwordRequest': (_) => const DemoAccessScreen(),
        'changePassword': (_) => const DemoAccessScreen(),
        'myOrder': (_) => const MyOrderScreen(),
        'register': (_) => const DemoAccessScreen(),
        'myCart': (_) => const MyCartScreen(),
        'profile': (_) => const UserProfileScreen(),
        'adminUser': (_) => const AdminUsersScreen(),
        'adminOrder': (_) => const AdminUsersOrdersScreens(),
      },
    );
  }
}
