import 'package:flutter/material.dart';

///Ésta clase se encarga de cargar los valors de los formularios de registro de usuario
///y validar que cumpla con los requerimientos mínimos.
class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String name = '';
  String lastname = '';
  String phone = '';
  String dateofbirth = '';
  String password = '';
  String confirmpassword = '';

  ///Valida si el formulario cumple con las condiciones mínimas para registar al ususario.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return true;
    }
  }
}
