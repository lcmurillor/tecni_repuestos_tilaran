import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:intl/intl.dart';

class CardListProduct extends StatelessWidget {
  const CardListProduct(
      {Key? key,
      required this.description,
      required this.quantity,
      required this.total,
      required this.productId,
      required this.userID})
      : super(key: key);
  final String description;
  final int quantity;
  final double total;
  final String productId;
  final String userID;
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(symbol: "₡ ");
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    description,
                    style:
                        CustomTextStyle.robotoSemiBold.copyWith(fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  _moldeRowInfo(title: 'Cantidad: ', value: '$quantity'),
                  _moldeRowInfo(
                      title: 'Total: ',
                      value: formatCurrency.format(total),
                      color: ColorStyle.mainBlue),
                  const SizedBox(height: 5),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconButtonCard(
                    padding: const EdgeInsets.all(10),
                    icon: const Icon(Icons.add_circle_outlined, size: 25),
                    color: ColorStyle.mainGreen,
                    onPressed: (() {})),
                _iconButtonCard(
                    padding: const EdgeInsets.all(10),
                    icon: const Icon(Icons.remove_circle_outlined, size: 25),
                    color: ColorStyle.mainBlue,
                    onPressed: (() {})),
                _iconButtonCard(
                    padding: const EdgeInsets.all(10),
                    icon: const Icon(Icons.delete, size: 25),
                    color: ColorStyle.mainRed,
                    onPressed: (() {})),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Row _moldeRowInfo(
    {required String title,
    required String value,
    Color color = const Color.fromRGBO(143, 143, 143, 1)}) {
  return Row(
    children: [
      Text(title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyle.robotoExtraBold),
      Text(
        value,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

//Método que contiene los ajustes de los iconbutton de las cards de my cart
IconButton _iconButtonCard(
    {required EdgeInsetsGeometry padding,
    required Icon icon,
    required Color color,
    required void Function() onPressed}) {
  return IconButton(
    constraints: const BoxConstraints(),
    padding: padding,
    icon: icon,
    color: color,
    onPressed: onPressed,
  );
}
