import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:intl/intl.dart';

class CardListProduct extends StatefulWidget {
  const CardListProduct({Key? key, required this.cart}) : super(key: key);
  final Cart cart;

  @override
  State<CardListProduct> createState() => _CardListProductState();
}

class _CardListProductState extends State<CardListProduct> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(symbol: "₡ ");
    final globalTotal = Provider.of<MyCartInfoProvider>(context);
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
                    widget.cart.description,
                    style:
                        CustomTextStyle.robotoSemiBold.copyWith(fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  _moldeRowInfo(
                      title: 'Cantidad: ', value: '${widget.cart.quantity}'),
                  _moldeRowInfo(
                      title: 'Total: ',
                      value: formatCurrency.format(widget.cart.total),
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
                    onPressed: (() {
                      FirebaseRealtimeService.getProductQuantity(
                              key: widget.cart.productId)
                          .then((value) {
                        if (widget.cart.quantity < value) {
                          setState(() {
                            widget.cart.quantity += 1;
                            widget.cart.total =
                                widget.cart.price * widget.cart.quantity;
                            FirebaseRealtimeService.updateCartValue(
                                    cart: widget.cart)
                                .then((value) =>
                                    FirebaseRealtimeService.getCartTotal().then(
                                        (value) => globalTotal.setTotal(
                                            total: value)));
                          });
                        } else {
                          NotificationsService.showErrorSnackbar(
                              'No tenemos más existencias de este articulo actualmente.');
                        }
                      });
                    })),
                _iconButtonCard(
                    padding: const EdgeInsets.all(10),
                    icon: const Icon(Icons.remove_circle_outlined, size: 25),
                    color: ColorStyle.mainBlue,
                    onPressed: (() {
                      if (widget.cart.quantity > 1) {
                        setState(() {
                          widget.cart.quantity -= 1;
                          widget.cart.total =
                              widget.cart.price * widget.cart.quantity;
                          FirebaseRealtimeService.updateCartValue(
                                  cart: widget.cart)
                              .then((value) =>
                                  FirebaseRealtimeService.getCartTotal().then(
                                      (value) =>
                                          globalTotal.setTotal(total: value)));
                        });
                      }
                    })),
                _iconButtonCard(
                    padding: const EdgeInsets.all(10),
                    icon: const Icon(Icons.delete, size: 25),
                    color: ColorStyle.mainRed,
                    onPressed: (() {
                      NotificationsService.displayDeleteDialog(
                        context: context,
                        text:
                            'Está seguro que desea elimianr ${widget.cart.description} del carrito?',
                        onPressed: () {
                          FirebaseRealtimeService.deleteCart(
                                  key: widget.cart.id)
                              .then((value) => Navigator.pushReplacementNamed(
                                  context, 'myCart'));
                        },
                      );
                    })),
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
