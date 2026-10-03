import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;

  ThemeProvider({required bool isDarkmode})
      : currentTheme = isDarkmode ? MainTheme.darkTheme : MainTheme.lightTheme;

  void setLigthMode() {
    currentTheme = MainTheme.lightTheme;
    notifyListeners();
  }

  void setDarkMode() {
    currentTheme = MainTheme.darkTheme;
    notifyListeners();
  }
}
