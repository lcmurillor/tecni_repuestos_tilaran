import 'package:flutter/material.dart';

class EditInfoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String lastname = '';
  String phone = '';
  int birthdate = 0;

  ///Valida si el formulario cumple con las condiciones mínimas para iniciar al sesión de un usuario.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
