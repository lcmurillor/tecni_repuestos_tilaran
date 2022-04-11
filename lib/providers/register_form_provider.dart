import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String name = '';
  String lastname = '';
  String phone = '';
  String dateofbirth = '';
  String password = '';
  String confirmpassword = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      print('Form valid ... Login');
      print('$email === $password === $name');
    } else {
      print('Form not valid');
    }
  }
}
