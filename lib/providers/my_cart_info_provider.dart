import 'package:flutter/Material.dart';

class MyCartInfoProvider extends ChangeNotifier {
  double _total = 0.00;

  setTotal({required double total}) {
    _total = total;
  }

  setPlusTotal({required double plus}) {
    _total = _total + plus;
  }

  setNotification() {
    notifyListeners();
  }

  double getTotal() {
    return _total;
  }
}
