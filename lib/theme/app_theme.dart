import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class MainTheme {
  static BoxShadow cardShadow = const BoxShadow(
      color: Colors.black12, offset: Offset(0, 0), blurRadius: 10);

  ///Configuración del tema claro y sus paramentros pro defecto.
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: ColorStyle.mainRed,

    ///Configuración del card.
    cardTheme: CardTheme(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 10,
        shadowColor: Colors.black26,
        color: Colors.white),

    ///Configuración del listTile (Utilizado en el drawer).
    listTileTheme: const ListTileThemeData(iconColor: Colors.black),
  );

  ///Configuración del tema oscurio y sus paramentros pro defecto.
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: ColorStyle.mainRed,

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
