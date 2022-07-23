import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class TertiaryButton extends StatelessWidget {
  ///Corresponde al botón con texto negro y una acción indicada en azul
  ///que se encuentra al final de diversos formularios de la aplicación.
  const TertiaryButton(
      {Key? key,
      required this.text,
      required this.buttonText,
      required this.onPressed})
      : super(key: key);
  final String text;
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ///Texto, primera premisa del botón o cunsulta.
        Text(text,
            textAlign: TextAlign.end, style: CustomTextStyle.robotoSemiBold),

        ///Botón, texto de color azul a que le corresponde una acción.
        TextButton(
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent)),
            onPressed: () => onPressed(),
            child: Text(buttonText,
                textAlign: TextAlign.start,
                style: CustomTextStyle.robotoExtraBold
                    .copyWith(color: ColorStyle.mainBlue)))
      ]),
    );
  }
}
