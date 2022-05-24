import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;

  ThemeProvider({required bool isDarkmode})
      : currentTheme = isDarkmode ? MainTheme.darkTheme : MainTheme.lightTheme;

  setLigthMode() {
    currentTheme = MainTheme.lightTheme;
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = MainTheme.darkTheme;
    notifyListeners();
  }
}
