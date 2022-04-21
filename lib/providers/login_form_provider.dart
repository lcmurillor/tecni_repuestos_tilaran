import 'package:flutter/material.dart';

///Ésta clase se encarga de cargar los valors de los formularios de inicio de sesión
///y validar que cumpla con los requerimientos mínimos.
class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  ///Valida si el formulario cumple con las condiciones mínimas para inicicar al sesión de un ususario.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
