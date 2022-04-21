import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, required this.text, required this.onPressed, this.size = 18})
      : super(key: key);
  final String text;
  final Function onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: ColorStyle.mainRed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 20),
          child: Text(text,
              style: CustomTextStyle.robotoExtraBold
                  .copyWith(fontSize: size, color: Colors.white)),
        ),
        onPressed: () => onPressed);
  }
}
