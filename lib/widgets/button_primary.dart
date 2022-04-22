import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class PrimaryButton extends StatelessWidget {
  ///Corresponde al botón rojo principal que se encuentra al final de diversos formularios 
  ///de la aplicación.
  const PrimaryButton(
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
    final size = MediaQuery.of(context).size;
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: ColorStyle.mainRed,
        child: SizedBox(
          width: size.width * 0.80,
          height: size.width * 0.13,
          child: Center(
            child: Text(text,
                style: CustomTextStyle.robotoMedium
                    .copyWith(fontSize: fontSize, color: Colors.white)),
          ),
        ),
        onPressed: () => onPressed());
  }
}
