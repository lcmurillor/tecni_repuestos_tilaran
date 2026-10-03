import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class DialogMyCart {
  static Future<void> displayMyCartDialog({required BuildContext context, required String code, required String total}) async {
    await LocalDataService.updateOrderStatus(orderId: code, status: 1);
    await LocalDataService.deleteUserCart();
    if (!context.mounted) return;
    await showDialog<void>(context: context, builder: (dialogContext) => AlertDialog(
      title: const Text('Pedido de demostración'),
      content: Text('Se creó el pedido simulado $code por $total.\n\nNo se realizará ningún cobro ni envío. Los cambios se pierden al recargar la página.'),
      actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Ver mis pedidos'))],
    ));
    if (context.mounted) Navigator.pushReplacementNamed(context, 'myOrder');
  }
}

class CustomTextOuput extends StatelessWidget {
  const CustomTextOuput({Key? key, required this.data, required this.icon})
      : super(key: key);

  final String data;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return CustomTextInput(
      readOnly: true,
      hintText: data,
      icon: icon,
      onChanged: (value) {},
      validator: (value) {
        return null;
      },
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: data)).then(
            (value) => NotificationsService.showSnackbar('Copiado $data'));
      },
    );
  }
}

// FLUJO ORIGINAL DE PAGO (desactivado):
// import 'package:flutter/material.dart';
// import 'package:tecni_repuestos/Services/services.dart';
// import 'package:tecni_repuestos/theme/themes.dart';
// import 'package:tecni_repuestos/widgets/widgets.dart';
// import 'package:flutter/services.dart';
//
// class DialogMyCart {
//   static displayMyCartDialog(
//       {required BuildContext context,
//       required String code,
//       required String total}) {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (context) {
//           return Scaffold(
//             backgroundColor: Colors.transparent,
//             body: AlertDialog(
//               elevation: 10,
//               title: Text(
//                 'Hemos recibido tu pedido',
//                 style: CustomTextStyle.robotoSemiBold.copyWith(fontSize: 30),
//                 textAlign: TextAlign.center,
//               ),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25)),
//               content: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     Text(
//                         'Para formalizar la compra, realice un depósito al siguiente número de cuenta IBAN del banco Nacional, o al número de cuenta Sinpe.\nEn el detalle del depósito indique le código de orden.',
//                         style: CustomTextStyle.robotoSemiBold,
//                         textAlign: TextAlign.center),
//                     const SizedBox(height: 10),
//                     const CustomTextOuput(
//                         data: 'CR51015102420010178491',
//                         icon: Icons.copy_outlined),
//                     const CustomTextOuput(
//                         data: '+50688353896', icon: Icons.copy_outlined),
//                     CustomTextOuput(data: code, icon: Icons.copy_outlined),
//                     CustomTextOuput(data: total, icon: Icons.copy_outlined),
//                     PrimaryButton(
//                       text: 'Enviar comprobante',
//                       onPressed: () =>
//                           DialogMyCartVoucher.displayMyCartVoucherDialog(
//                               context: context, code: code),
//                     ),
//                     SecundaryButton(
//                         text: 'Regresar',
//                         onPressed: () => Navigator.pop(context))
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
//
