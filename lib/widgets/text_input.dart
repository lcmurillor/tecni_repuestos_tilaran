import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class CustomTextInput extends StatelessWidget {
  ///Corresponde a una istancia de un objeto de tipo TextFormField, personalizado
  ///para que todos los inputs tengan el mismo aspecto.
  const CustomTextInput(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.onChanged,
      required this.validator,
      this.autocorrect = false,
      this.controller,
      this.height = 15,
      this.keyboardType,
      this.obscureText = false,
      this.onFieldSubmitted,
      this.onTap,
      this.readOnly = false,
      this.maxLines = 1})
      : super(key: key);

  final bool autocorrect;
  final bool obscureText;
  final bool readOnly;
  final double height;
  final Function? onFieldSubmitted;
  final Function(String) onChanged;
  final IconData icon;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function()? onTap;

  final TextEditingController? controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        maxLines: maxLines,
        autocorrect: autocorrect,
        controller: controller,
        decoration: InputStyle.mainInput(hintText: hintText, icon: icon),
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        validator: validator,
      ),
      SizedBox(height: height)
    ]);
  }
}
