import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

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
    final total = Provider.of<MyCartInfoProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBarBackArrow(
            actionIcon: Icons.delete_outline_rounded,
            onPressed: () {
              print('borrar lista');
            },
            navigatorOnPressed: () => Navigator.pop(context),
          ),
          body: Column(
            children: [
              const SizedBox(height: 20),
              Text('Mi carrito',
                  style:
                      CustomTextStyle.robotoExtraBold.copyWith(fontSize: 40)),
              const SizedBox(height: 20),
              FutureBuilder(
                  future: FirebaseRealtimeService.getCart(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasError) {
                      return NotificationsService.showErrorSnackbar(
                          'Ha ocurrido un error a la hora de cargar los datos.');
                    }

                    if (!snapshot.hasData) {
                      return const CustomProgressIndicator();
                    }

                    final data = snapshot.data!;

                    ///Ordena el arreglo de datos alfabéticamente.
                    final orderData = data
                      ..sort((a, b) => a.description.compareTo(b.description));
                    total.setTotal(total: 0);
                    return SizedBox(
                        height: size.height * 0.42,
                        width: double.infinity,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: orderData.length,
                          itemBuilder: (context, index) {
                            total.setPlusTotal(plus: orderData[index].price);
                            return CardListProduct(
                                description: orderData[index].description,
                                productId: orderData[index].id,
                                quantity: 1,
                                total: orderData[index].price * 1,
                                userID:
                                    FirebaseAuthService.auth.currentUser!.uid);
                          },
                        ));
                  }),

              ///Corresponde al espacio en la parte inferior de la pantalla en la cual se
              ///muestra el costo total de la compra por los productos del carrito y se disponde de
              ///la dirrreción a la cual se entregaría el paquete.

              Container(
                height: size.height * 0.35,
                width: size.width,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    _invoiceTotalInfo(context),
                    const CardUserAddress(),
                    const SizedBox(height: 10),
                    PrimaryButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlaceholderScreen(
                                  text: 'metodos de pago'),
                            ),
                          );
                        },
                        text: "Pagar")
                  ],
                ),
              )
            ],
          )),
    );
  }

  ///Método que construye el reome de la orden de compra del usuario.
  SizedBox _invoiceTotalInfo(BuildContext context) {
    final formatCurrency = NumberFormat.currency(symbol: "₡ ");
    final total = Provider.of<MyCartInfoProvider>(context, listen: true);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 10),
          _moldeRowInfo(
              title: 'Subtotal: ',
              value: formatCurrency.format((total.getTotal()))),
          _moldeRowInfo(
              title: 'IVA: ',
              value: formatCurrency.format((total.getTotal() * 0.13))),
          _moldeRowInfo(
              title: 'Total: ',
              value: formatCurrency.format((total.getTotal() * 1.13)),
              color: ColorStyle.mainBlue)
        ],
      ),
    );
  }

  //Método que cada una de las lineas del detalle de la orden del usuario.
  Row _moldeRowInfo(
      {required String title,
      required String value,
      Color color = const Color.fromRGBO(143, 143, 143, 1)}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
          style: TextStyle(
              color: color, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class CardUserAddress extends StatelessWidget {
  ///Éste widget es un card personalizado el cual es usado para mostrar de manera cómoda
  ///los datos de las diferentes direcciones guardadas por un usuario y junto con estos datos,
  ///las opciones de editar o eliminar la información.
  const CardUserAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      ///Permite darle una espacio a los costados horizontales del contenedor.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(children: [
          ///Corresponde al icono de la localización que se encuentra a la izquierda.
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              MdiIcons.mapMarkerRadius,
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
                    '${'address.canton'}, ${'address.province'}.',
                    style: CustomTextStyle.robotoMedium.copyWith(fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'address.address',
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
                ///Botón para cambiar la dirreción de facturación.
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 40,
                    color: ColorStyle.textGrey,
                  ),
                  onPressed: () => Navigator.pushNamed(context, 'addresses'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
