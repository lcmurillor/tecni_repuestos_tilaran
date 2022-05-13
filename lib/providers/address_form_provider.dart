import 'package:flutter/material.dart';

class AddressFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String address = '';
  String canton = '';
  String province = '';
  String userId = '';

  ///Valida si el formulario cumple con las condiciones mínimas para cargar un nueva dirreción.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
