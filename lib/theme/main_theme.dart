import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class MainTheme {
  static BoxShadow cardShadow = const BoxShadow(
      color: Colors.black12, offset: Offset(0, 0), blurRadius: 10);

  ///Configuración del tema claro y sus paramentros por defecto.
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    ///Configuración de colores de la aplicación.
    colorScheme: const ColorScheme.light().copyWith(
      primary: ColorStyle.mainRed,
      primaryContainer: ColorStyle.errorRed,
      secondary: ColorStyle.mainBlue,
    ),

    ///Configuración del card.
    cardTheme: CardTheme(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 10,
        shadowColor: Colors.black26,
        color: Colors.white),

    ///Configuración del listTile (Utilizado en el drawer).
    listTileTheme: const ListTileThemeData(iconColor: Colors.black),

    ///Configuración del inputDecorationTheme (Utilizado en todos los inputs).
    inputDecorationTheme: const InputDecorationTheme(),
  );

  ///Configuración del tema oscuro y sus parámentros por defecto.
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    ///Configuración de colores de la aplicación.
    colorScheme: const ColorScheme.light().copyWith(
      primary: ColorStyle.mainRed,
      primaryContainer: ColorStyle.errorRed,
      secondary: ColorStyle.mainBlue,
    ),

    ///Configuración del card.
    cardTheme: CardTheme(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 10,
        shadowColor: Colors.black),

    ///Configuración del listTile (Utilizado en el drawer).
    listTileTheme: const ListTileThemeData(iconColor: Colors.white),

    ///Configuración del inputDecorationTheme (Utilizado en todos los inputs).
    inputDecorationTheme: const InputDecorationTheme(),
  );
}
