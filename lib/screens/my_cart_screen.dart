import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/services/services.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

class MyCartScreen extends StatefulWidget {
  ///En esta pantalla se muestra una lista de productos los cuales el usuario registrado a guardado
  ///con la tentativa de comprar o por lo mentos, tener guardados para su consulta posterior.
  ///La lista es idividual para cada usuario y cada uno solo puede tener una lista de articulos en el carrito.
  ///Los datos de esta lista se mantienen almacenados en la base de datos con la inteción de que pueda ser consultada
  ///por el usuarios al ingresar a su cuenta en cualquier dispositivo.
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  ///En esta función se definen los valores por efecto para cargar la pantalla con los datos
  ///actualizados.
  @override
  void initState() {
    final myCartInfo = Provider.of<MyCartInfoProvider>(context, listen: false);

    Future.delayed(Duration.zero, () async {
      FirebaseRealtimeService.getCartTotal()
          .then((value) => myCartInfo.setTotal(total: value));
    });
    if (FirebaseAuthService.auth.currentUser != null) {
      FirebaseRealtimeService.getAddressByUser(
              uid: FirebaseAuthService.auth.currentUser!.uid)
          ?.then((value) {
        myCartInfo.setAddress(address: value);
      });
    }
    Provider.of<ComeFromProvider>(context, listen: false)
        .setScreen(screen: 'myCart');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myCartInfo = Provider.of<MyCartInfoProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBarBackArrow(
            actionIcon: Icons.delete_outline_rounded,
            onPressed: () {
              NotificationsService.displayDeleteDialog(
                context: context,
                text: '¿Está seguro que desea vaciar el carrito?',
                onPressed: () => {
                  FirebaseRealtimeService.deleteUserCart(),
                  Navigator.pushReplacementNamed(context, 'myCart')
                },
              );
            },
            navigatorOnPressed: () =>
                Navigator.pushReplacementNamed(context, 'home'),
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              Text('Mi carrito',
                  style:
                      CustomTextStyle.robotoExtraBold.copyWith(fontSize: 40)),
              const SizedBox(height: 10),
              Expanded(
                child: (FirebaseAuthService.auth.currentUser != null)
                    ? FirebaseAnimatedList(
                        ///Resive la consulta de la base de datos.
                        query: FirebaseRealtimeService.getCart(),
                        defaultChild: const CustomProgressIndicator(),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, snapshot, animation, index) {
                          if (!snapshot.exists) {
                            return NotificationsService.showErrorSnackbar(
                                'Ha ocurrido un error a la hora de cargar los datos.');
                          }
                          final cart = Cart.fromMap(
                              jsonDecode(jsonEncode(snapshot.value)));
                          return CardListProduct(cart: cart);
                        },
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: const Text(
                            'No disponde de productos en su carrito.'),
                      ),
              ),

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
                        onPressed: () async {
                          ///Valida si existen prodductos en el carrito.
                          if (await FirebaseRealtimeService.haveCart()) {
                            ///Valida si el usuario tiene un direción agregada.
                            if (myCartInfo.getAddress().canton != '') {
                              ///Valida si el usuario tiene otra orden No tramidada, si es así, elimina la anterir y define una nueva.
                              if (await FirebaseRealtimeService
                                  .validateExistingOrders()) {
                                FirebaseRealtimeService.deleteOrderStatus0();
                              }
                              FirebaseRealtimeService.setOrder(context: context)
                                  .then((value) =>
                                      DialogMyCart.displayMyCartDialog(
                                          context: context,
                                          code: value,
                                          total: (myCartInfo.getTotal() * 1.13)
                                              .toStringAsFixed(2)));
                            } else {
                              NotificationsService.showErrorSnackbar(
                                  'No tiene nungún dirección de facturación argegada.');
                            }
                          } else {
                            NotificationsService.showErrorSnackbar(
                                'No tiene nungún producto agregado al carrito.');
                          }
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
  _invoiceTotalInfo(BuildContext context) {
    final formatCurrency = NumberFormat.currency(symbol: "₡ ");
    final myCartInfo = Provider.of<MyCartInfoProvider>(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 10),
          _moldeRowInfo(
              title: 'Subtotal: ',
              value: formatCurrency.format((myCartInfo.getTotal()))),
          _moldeRowInfo(
              title: 'IVA: ',
              value: formatCurrency.format((myCartInfo.getTotal() * 0.13))),
          _moldeRowInfo(
              title: 'Total: ',
              value: formatCurrency.format((myCartInfo.getTotal() * 1.13)),
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
    final myCartInfo = Provider.of<MyCartInfoProvider>(context);

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
                    (myCartInfo.getAddress().canton == '')
                        ? 'No tienes ninguna dirección de facturación.'
                        : '${myCartInfo.getAddress().canton}, ${myCartInfo.getAddress().province}.',
                    style: CustomTextStyle.robotoMedium.copyWith(fontSize: 17),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    (myCartInfo.getAddress().address == '')
                        ? 'Por favor , agrega una nueva dirreción.'
                        : myCartInfo.getAddress().address,
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
