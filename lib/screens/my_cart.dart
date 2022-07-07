import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBackArrow(
        actionIcon: Icons.delete_outline_rounded,
        onPressed: () {},
        navigatorOnPressed: () => Navigator.pushNamed(context, 'home'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(children: [
              const SizedBox(
                height: 50,
                width: double.infinity,
              ),
              Text('Mi carrito',
                  style:
                      CustomTextStyle.robotoExtraBold.copyWith(fontSize: 40)),
              const SizedBox(
                height: 40,
                width: double.infinity,
              ),
              cardMyCart(),
              const SizedBox(height: 150),
              Container(
                  height: 250,
                  width: 400,
                  color: Colors.grey[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      moldeRowInfo(
                        const EdgeInsets.fromLTRB(110, 0, 0, 0),
                        'Subtotal: ',
                        CustomTextStyle.robotoExtraBold,
                        CustomTextStyle.robotoMedium
                            .copyWith(color: Colors.black38),
                        'C85.500.00',
                      ),
                      Center(
                        child: moldeRowInfo(
                          const EdgeInsets.fromLTRB(110, 0, 0, 0),
                          'IVA: ',
                          CustomTextStyle.robotoExtraBold,
                          CustomTextStyle.robotoMedium
                              .copyWith(color: Colors.black38),
                          '13.500.00',
                        ),
                      ),
                      moldeRowInfo(
                        const EdgeInsets.fromLTRB(108, 0, 0, 0),
                        'Total: ',
                        CustomTextStyle.robotoExtraBold,
                        CustomTextStyle.robotoExtraBold
                            .copyWith(color: ColorStyle.mainBlue),
                        'C99.000.00',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CardContainer(
                        child: Row(children: [
                          const Icon(
                            Icons.map_sharp,
                            color: Colors.red,
                            size: 40,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              width: 210,
                              child: Column(
                                children: [
                                  Text(" Tilaran Guanacaste",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.robotoSemiBold),
                                  Text(
                                    "Direccion de un punto de referencia, una distancia definida a un lugar específico",
                                    maxLines: 2,
                                    style: CustomTextStyle.robotoSemiBold
                                        .copyWith(
                                            color: Colors.grey[500],
                                            fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              alignment: Alignment.centerRight,
                              icon: const Icon(Icons.arrow_forward_ios_rounded),
                              onPressed: () {}),
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PrimaryButton(
                        onPressed: () {},
                        text: "Pagar",
                      )
                    ],
                  )),
            ]),
          ],
        ),
      ),
    );
  }

  CardContainer cardMyCart() {
    return CardContainer(
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: Column(
            //TODO: Se desborda si el nombre del articulo es muy largo
            children: [
              moldeRowInfo(
                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  'Titulo del artículo publicado ',
                  CustomTextStyle.robotoSemiBold,
                  CustomTextStyle.robotoSemiBold),
              moldeRowInfo(
                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                'Cantidad: ',
                CustomTextStyle.robotoSemiBold,
                CustomTextStyle.robotoMedium.copyWith(color: Colors.black38),
                '3',
              ),
              moldeRowInfo(
                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                'Total: ',
                CustomTextStyle.robotoMedium,
                CustomTextStyle.robotoExtraBold
                    .copyWith(color: ColorStyle.mainBlue),
                'C18.300.00',
              ),
            ],
          ),
        ),
        iconButtonCard(
            const EdgeInsets.fromLTRB(0, 0, 3, 0),
            const Icon(Icons.remove_circle),
            const Color.fromRGBO(0, 152, 181, 1),
            () {}),
        iconButtonCard(
          EdgeInsets.zero,
          const Icon(Icons.add_circle),
          const Color.fromRGBO(0, 149, 111, 1),
          () {},
        ),
        iconButtonCard(
          EdgeInsets.zero,
          const Icon(Icons.delete_forever),
          const Color.fromRGBO(214, 39, 31, 1),
          () {},
        ),
      ]),
    );
  }

  IconButton iconButtonCard(EdgeInsetsGeometry padding, Icon icon, Color color,
      void Function() onPressed) {
    return IconButton(
      constraints: const BoxConstraints(),
      padding: padding,
      icon: icon,
      color: color,
      onPressed: onPressed,
    );
  }

  Row moldeRowInfo(EdgeInsetsGeometry padding, String text, TextStyle style,
      TextStyle style2,
      [String text2 = '', TextAlign textalign = TextAlign.center]) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: padding,
        ),
        Text(text,
            textAlign: textalign,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style),
        Text(text2,
            textAlign: textalign,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style2
            //CustomTextStyle.robotoMedium.copyWith(color: ColorStyle.mainBlue),
            ),
      ],
    );
  }
}
