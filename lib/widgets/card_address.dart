import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key, required this.title, required this.text})
      : super(key: key);
  final String title;
  final String text;

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
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            Icons.map,
            color: ColorStyle.mainRed,
            size: 50,
          ),
        ),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: CustomTextStyle.robotoMedium.copyWith(fontSize: 20),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: CustomTextStyle.robotoMedium
                      .copyWith(fontSize: 15, color: ColorStyle.textGrey),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 40,
                  color: ColorStyle.mainGreen,
                ),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.delete_outline,
                    size: 40, color: ColorStyle.mainRed),
                onPressed: () {
                  NotificationsService.displayDeleteDialog(
                      context,
                      '¿Está seguro que desea eliminar la dirrección: $text?',
                      () {});
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
