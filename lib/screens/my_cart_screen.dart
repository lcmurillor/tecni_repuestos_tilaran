import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class MyCartScreen extends StatelessWidget {
  ///En esta pantalla se muestra una lista de productos los cuales el usuario registrado a guardado
  ///con la tentativa de comprar o por lo mentos, tener guardados para su consulta posterior.
  ///La lista es idividual para cada usuario y cada uno solo puede tener una lista de articulos en el carrito.
  ///Los datos de esta lista se mantienen almacenados en la base de datos con la inteción de que pueda ser consultada
  ///por el usuarios al ingresar a su cuenta en cualquier dispositivo.
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarBackArrow(
          actionIcon: Icons.delete_outline_rounded,
          onPressed: () {
            //TODO: Realizar la funcion para vaciar el carrito.
          },
          navigatorOnPressed: () => Navigator.pop(context),
        ),
        body: Column(children: [
          const SizedBox(height: 50),
          Text('Mi carrito',
              style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 40)),
          const SizedBox(height: 40),
          Expanded(
              child: Stack(
            children: [
              ///Conexión a la base de datos para crear la lista de articulos del carrito.
              // StreamBuilder(
              //   stream: stream,
              //   initialData: initialData,
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     return Container(
              //       child: child,
              //     );
              //   },
              // ),

              ///Corresponde al espacio en la parte inferior de la pantalla en la cual se
              ///muestra el costo total de la compra por los articulos del carrito y se disponde de
              ///la dirrreción a la cual se entregaría el paquete.
              Positioned(
                bottom: 0,
                child: Container(
                    height: 250,
                    width: size.width,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        _invoiceTotalInfo(),
                        Card(
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
                                icon:
                                    const Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {}),
                          ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PrimaryButton(
                          onPressed: () {
                            //TODO: Agregar las funciones de pago.
                          },
                          text: "Pagar",
                        )
                      ],
                    )),
              )
            ],
          ))
        ]),
      ),
    );
  }

  Column _invoiceTotalInfo() {
    return Column(
      children: [
        const SizedBox(height: 20),
        moldeRowInfo(
          const EdgeInsets.fromLTRB(110, 0, 0, 0),
          'Subtotal: ',
          CustomTextStyle.robotoExtraBold,
          CustomTextStyle.robotoMedium.copyWith(color: ColorStyle.mainGrey),
          'C85.500.00',
        ),
        moldeRowInfo(
          const EdgeInsets.fromLTRB(110, 0, 0, 0),
          'IVA: ',
          CustomTextStyle.robotoExtraBold,
          CustomTextStyle.robotoMedium.copyWith(color: ColorStyle.mainGrey),
          '13.500.00',
        ),
        moldeRowInfo(
          const EdgeInsets.fromLTRB(108, 0, 0, 0),
          'Total: ',
          CustomTextStyle.robotoExtraBold,
          CustomTextStyle.robotoExtraBold.copyWith(color: ColorStyle.mainBlue),
          'C99.000.00',
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Card cardMyCart() {
    return Card(
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: Column(
            //TODO: Se desborda si el nombre del articulo es muy largo, porfa revisar cual puede ser el error
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

//Método que contiene los ajustes de los iconbutton de las cards de my cart
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

//Método que contiene los ajutes de las cartas de mycart
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
