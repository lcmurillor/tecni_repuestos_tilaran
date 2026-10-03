import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';

class MyCartInfoProvider extends ChangeNotifier {
  double _total = 0.00;
  int _count = 0;

  Address _address = Address(
      address: '', canton: '', id: '', province: '', userId: '', last: false);

  void setTotal({required double total}) {
    _total = total;
    notifyListeners();
  }

  double getTotal() {
    return _total;
  }

  void setCount({required int count}) {
    _count = count;
    notifyListeners();
  }

  int getCount() {
    return _count;
  }

  void setAddress({required Address address}) {
    _address = address;
    notifyListeners();
  }

  Address getAddress() {
    return _address;
  }
}
