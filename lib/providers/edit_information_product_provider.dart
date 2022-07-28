import 'package:flutter/material.dart';

class EditInfoProductProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String description = '';
  String code = '';
  String cost = '';
  String location = '';
  String category = '';
  String type = '';
  String price = '';
  String quantity = '';

  ///Valida si el formulario cumple con las condiciones mínimas para iniciar al sesión de un usuario.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
