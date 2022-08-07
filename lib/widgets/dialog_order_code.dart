// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/providers/order_form_provider.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

displaySetVoucher({
  required BuildContext context,
  String title = 'Adjunte el número del código guía',
  final String orderId = '',
  final int status = 0,
  final String code = '',
  //  void Function()? onPressed
}) {
  // final orderFormProvider =
  //     Provider.of<OrderFormProvider>(context, listen: false);
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          elevation: 10,
          title: Text(title,
              style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 27),
              textAlign: TextAlign.center),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          content: Form(
            //  key: orderFormProvider.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextInput(
                  //  key: orderFormProvider.formKey,
                  height: 20,
                  hintText: 'Código guía',
                  icon: MdiIcons.barcode,
                  onChanged: (p0) => () {},
                  // orderFormProvider.code = value,
                  keyboardType: TextInputType.streetAddress,
                ),
                PrimaryButton(
                  text: 'Aplicar cambio',
                  onPressed: () {
                    // FirebaseRealtimeService.updateOrderCode(
                    //     orderId: orderId,
                    //     status: status,
                    //     code: orderFormProvider.code);
                  },
                ),
                SecundaryButton(
                    text: 'Regresar',
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      });
}
