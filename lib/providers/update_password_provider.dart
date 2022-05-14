import 'package:flutter/material.dart';

class UpdatePasswordProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String password = '';

  ///Valida si el formulario cumple con las condiciones mínimas para iniciar al sesión de un usuario.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
