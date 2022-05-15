import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';

///Éste form provider guarda y evalua las condiciones necesarias a gestionar para que 
///el usuario que quiera cambiar su contraseña. si no se cumplen las condiciones del formulario 
///no se permite acutalizar la contraseña.
class UpdatePasswordFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String currentPassword = '';
  String newPassword = '';
  String confirmNewPassword = '';

  ///Evaúa si se cumplen con las condicones necesarias para cambiar la contraseña de cara 
  ///a lo que corresponde al formulario, ya sea que este se cumpla con sus condiciones mínimas 
  ///y que las contraseñas coinsidan.
  bool validateForm() {
    if (formKey.currentState!.validate() && newPassword == confirmNewPassword) {
      return true;
    } else if (newPassword != confirmNewPassword) {
      NotificationsService.showErrorSnackbar('Las contraseñas no coinciden.');
    }
    return false;
  }
}
