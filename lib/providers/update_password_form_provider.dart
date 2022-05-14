import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';

//TODO documentar
class UpdatePasswordFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String currentPassword = '';
  String newPassword = '';
  String confirmNewPassword = '';

  //TODO Documentar
  bool validateForm() {
    if (formKey.currentState!.validate() && newPassword == confirmNewPassword) {
      return true;
    } else if (newPassword != confirmNewPassword) {
      NotificationsService.showErrorSnackbar('Las contraseñas no coinciden.');
    }
    return false;
  }
}
