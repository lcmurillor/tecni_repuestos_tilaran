import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';


///Ésta clase se encarga de cargar los valors de los formularios de registro de usuario
///y validar que cumpla con los requerimientos mínimos.
class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String name = '';
  String lastname = '';
  String phone = '';
  int birthdate = 0;
  String password = '';
  String confirmPassword = '';

  ///Valida si el formulario cumple con las condiciones mínimas para registar al ususario.
  bool validateForm(bool validated) {
    if (formKey.currentState!.validate() &&
        validated == true &&
        password == confirmPassword) {
      return true;
    } else if (validated == false) {
      NotificationsService.showErrorSnackbar(
          'Debe aceptar términos y condiciones.');
      return false;
    } else if (password != confirmPassword) {
      NotificationsService.showErrorSnackbar('La contraseña no concide.');
    }
    return false;
  }
}
