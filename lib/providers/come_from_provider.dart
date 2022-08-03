import 'package:flutter/Material.dart';

class ComeFromProvider extends ChangeNotifier {
  String _screen = '';

  setScreen({required String screen}) {
    _screen = screen;
  }

  String getScreen() {
    return _screen;
  }
}
