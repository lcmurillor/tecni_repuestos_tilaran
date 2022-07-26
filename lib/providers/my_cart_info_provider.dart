import 'package:flutter/Material.dart';

class MyCartInfoProvider extends ChangeNotifier {
  double _total = 0.00;
  int _count = 0;

  setTotal({required double total}) {
    _total = total;
    notifyListeners();
  }

  double getTotal() {
    return _total;
  }

  setCount({required int count}) {
    _count = count;
    notifyListeners();
  }

  int getCount() {
    return _count;
  }
}
