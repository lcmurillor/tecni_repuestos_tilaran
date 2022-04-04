import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/app_theme.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: _createCardShape(),
        child: child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [MainTheme.cardShadow]);
}
