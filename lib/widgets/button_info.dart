import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
    //   required this.faicon,
  }) : super(key: key);
  final void Function()? onPressed;
  final IconData icon;
  final String text;
  // final IconData faicon;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
          child: Container(
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorStyle.buttonGray),
              width: size.width * 0.80,
              height: size.width * 0.12,
              //color: ColorStyle.buttonGray,
              child: Row(
                children: [
                  ///ICONO al costado izquiero
                  Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: ColorStyle.mainRed),
                        child: Icon(
                          icon,
                          size: 18,
                          color: Colors.white,
                        ),
                      )),

                  ///TEXTO
                  Expanded(
                    child: Text(text,
                        style: CustomTextStyle.robotoMedium.copyWith(
                            fontSize: 18, color: ColorStyle.textGrey)),
                  ),

                  ///ICONO en el costado derecho
                  _faIconButtons(FontAwesomeIcons.chevronRight),
                ],
              )),
          onTap: onPressed),
    );
  }
}

FaIcon _faIconButtons(IconData faicon) {
  return FaIcon(
    faicon,
    size: 30,
    color: ColorStyle.textGrey,
  );
}
