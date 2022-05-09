import 'package:flutter/material.dart';

///Ésta clase se encarga de cargar los valores del formulario de recuperación de contraseña
///y validar que cumpla con los requerimientos mínimos.
class RequestPasswordFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';

  ///Valida si el formulario cumple con las condiciones mínimas para evaluar el correo en la base de datos.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
