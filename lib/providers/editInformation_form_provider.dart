import 'package:flutter/material.dart';

class EditInfoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String lastname = '';
  String phone = '';
  int dateofbirth = 0;

  ///Valida si el formulario cumple con las condiciones mínimas para registar al ususario.
}
