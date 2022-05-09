import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  ///Este widget corresponde a un mensaje que se muestra en la parte inferir del dispositivo
  ///en caso de errores o para indicar un comportamineto no deseado de la aplicación o acciones del
  ///usuario.
  static showErrorSnackbar(String message) async {
    final snackBar = SnackBar(
        content: Text(message,
            textAlign: TextAlign.center,
            style: CustomTextStyle.robotoMedium
                .copyWith(fontSize: 20, color: Colors.white)),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorStyle.errorRed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));

    messengerKey.currentState!.showSnackBar(snackBar);
  }

  ///Este widget corresponde a un mensaje que se muestra en la parte inferir del dispositivo
  ///para mostrar mensaje que no corresponden a ningun error y darle información al usuario
  ///respecto al comportamiento de la aplicación.
  static showSnackbar(String message) async {
    final snackBar = SnackBar(
        content: Text(message,
            textAlign: TextAlign.center,
            style: CustomTextStyle.robotoMedium
                .copyWith(fontSize: 20, color: Colors.white)),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorStyle.mainGreen,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
