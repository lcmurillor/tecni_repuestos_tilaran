import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      ///Contrucción de la decoración y dimenciones del conetendor.
      height: size.height * 0.20,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [MainTheme.cardShadow]),

      ///Construcción del contenido.
      child: Row(children: [
        Icon(
          Icons.map,
          color: ColorStyle.mainRed,
          size: 50,
        ),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Text(
              'Tilaran, Guanacaste.',
              style: CustomTextStyle.robotoMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Incididunt labore ex in incididunt Lorem elit adipisicing enim laborum occaecat qui eiusmod labore esse.',
              style: CustomTextStyle.robotoMedium
                  .copyWith(fontSize: 15, color: ColorStyle.textGrey),
            ),
          ]),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {},
        ),
      ]),
    );
  }
}
