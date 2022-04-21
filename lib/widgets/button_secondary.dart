import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class SecundaryButton extends StatelessWidget {
  const SecundaryButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(0)),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent)),
        onPressed: () => onPressed,
        child: Text(text,
            style: CustomTextStyle.robotoExtraBold
                .copyWith(color: ColorStyle.mainBlue)));
  }
}
