import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class SecundaryButton extends StatelessWidget {
  ///Corresponde al botón azul secundario que se encuentra al final de algunos formularios
  ///de la aplicación.
  const SecundaryButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.fontSize = 18})
      : super(key: key);
  final String text;
  final Function onPressed;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(0)),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent)),
        onPressed: () => onPressed(),
        child: Text(text,
            style: CustomTextStyle.robotoMedium
                .copyWith(color: ColorStyle.mainBlue, fontSize: fontSize)));
  }
}
