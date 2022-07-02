import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBackArrow(
          useActions: false, navigatorOnPressed: () => Navigator.pop(context)),
      body: Column(children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        Text('Mi carrito',
            style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 40)),
        const SizedBox(
          height: 40,
          width: double.infinity,
        ),
        CardContainer(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(
              child: Column(
                children: [
                  moldeRowInfo(
                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      'Titulo del artículo publicado ',
                      CustomTextStyle.robotoSemiBold,
                      CustomTextStyle.robotoSemiBold),
                  moldeRowInfo(
                    const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    'Cantidad: ',
                    CustomTextStyle.robotoSemiBold,
                    CustomTextStyle.robotoMedium
                        .copyWith(color: Colors.black38),
                    '3',
                  ),
                  moldeRowInfo(
                    const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    'Total: ',
                    CustomTextStyle.robotoMedium,
                    CustomTextStyle.robotoExtraBold
                        .copyWith(color: ColorStyle.mainBlue),
                    'C18.300.00',
                  ),
                ],
              ),
            ),
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.remove_circle,
                  color: Color.fromRGBO(0, 152, 181, 1)),
              onPressed: () {},
            ),
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add_circle,
                  color: Color.fromRGBO(0, 149, 111, 1)),
              onPressed: () {},
            ),
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.delete_forever,
                  color: Color.fromRGBO(214, 39, 31, 1)),
              onPressed: () {},
            )
          ]),
        ),
      ]),
    );
  }

  Row moldeRowInfo(
    EdgeInsetsGeometry padding,
    String text,
    TextStyle style,
    TextStyle style2, [
    String text2 = '',
  ]) {
    return Row(
      children: [
        Padding(
          padding: padding,
        ),
        Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: style),
        Text(text2, maxLines: 1, overflow: TextOverflow.ellipsis, style: style2
            //CustomTextStyle.robotoMedium.copyWith(color: ColorStyle.mainBlue),
            ),
      ],
    );
  }
}
