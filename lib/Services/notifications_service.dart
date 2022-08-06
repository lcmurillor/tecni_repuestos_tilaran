import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/firebase_realtime_service.dart';
import 'package:tecni_repuestos/providers/order_form_provider.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

///Esta clase permite gestionar de manera controlada los diferentes tipos de cuadros de dialogo que son
///usados por la aplicación para dar información o advertir al usuario.
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

  ///Dialogo para indicar al usuario que está a punto de eliminar un elemento,
  ///para que este método sea reutilizable para diferentes pantallas, se debe indicar
  ///en el "text" un mensaje como "¿Está seguro que desea eliminar ... ?" seguido del nombre
  ///o atributo descriptivo de lo que se busca eliminar y en la función "onPressed" se realiza el
  ///llamado a la bae de datos al mento específico.
  static displayDeleteDialog(
      {required BuildContext context,
      String title = 'Eliminar',
      required String text,
      void Function()? onPressed}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              elevation: 10,
              title: Text(title,
                  style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 35),
                  textAlign: TextAlign.center),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(text,
                      style: CustomTextStyle.robotoMedium,
                      textAlign: TextAlign.center)
                ],
              ),
              actions: actions(context, onPressed));
        });
  }

  ///Esta lista corresponde a los dos botones que se encuentran en la parte inferior del cuadro de dialogo.
  static List<Widget> actions(
      BuildContext context, void Function()? onPressed) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(0)),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent)),
            onPressed: onPressed,
            child: Text(
              'Aceptar',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(0)),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent)),
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            )),
      ),
    ];
  }
}
