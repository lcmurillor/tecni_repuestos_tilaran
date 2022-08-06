import 'package:flutter/material.dart';

class OrderFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String code = '';
}
