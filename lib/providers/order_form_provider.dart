import 'package:flutter/material.dart';

class OrderFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String shippingCode = '';
  int arrivelDate = 0;

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
