import 'package:flutter/material.dart';

import '../Services/notifications_service.dart';

///Ésta clase se encarga de cargar los valors de los formularios de registro de usuario
///y validar que cumpla con los requerimientos mínimos.
class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String name = '';
  String lastname = '';
  String phone = '';
  int dateofbirth = 0;
  String password = '';
  String confirmpassword = '';

  ///Valida si el formulario cumple con las condiciones mínimas para registar al ususario.
  bool validateForm(bool validated) {
    if (formKey.currentState!.validate() && validated == true) {
      return true;
    } else if (validated == false) {
      NotificationsService.showSnackbar('Debe aceptar términos y condiciones.');
      return false;
    }
    return false;
  }
}
