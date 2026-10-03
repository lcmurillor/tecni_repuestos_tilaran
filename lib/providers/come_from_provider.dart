import 'package:flutter/material.dart';

class ComeFromProvider extends ChangeNotifier {
  String _screen = '';

  void setScreen({required String screen}) {
    _screen = screen;
  }

  String getScreen() {
    return _screen;
  }
}
