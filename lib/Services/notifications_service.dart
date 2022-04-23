import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  ///Este widget corresponde a un mensaje que se muestra en la parte inferir del dispositivo
  static showSnackbar(String message) async {
    final snackBar = SnackBar(
        content: Text(message,
            textAlign: TextAlign.center,
            style: CustomTextStyle.robotoMedium
                .copyWith(fontSize: 20, color: Colors.white)),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 250, 0, 0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
