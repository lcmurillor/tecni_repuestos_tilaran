import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: ColorStyle.mainRed));
  }
}
