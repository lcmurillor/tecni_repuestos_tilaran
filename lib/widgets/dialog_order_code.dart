import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

class DialogOrderCode {
  static displaySetVoucher(
      {required BuildContext context,
      required Order order,
      void Function()? onPressed}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            title: Text('Adjunte la información del envío',
                style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 27),
                textAlign: TextAlign.center),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: _OrderForm(order: order)),
          );
        });
  }
}

class _OrderForm extends StatelessWidget {
  const _OrderForm({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderFormProvider(),
      builder: (context, child) {
        final orderFormProvider =
            Provider.of<OrderFormProvider>(context, listen: false);
        final _dataController = TextEditingController();
        return Form(
          key: orderFormProvider.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextInput(
                height: 20,
                hintText: 'Código guía',
                icon: MdiIcons.barcode,
                onChanged: (value) => orderFormProvider.shippingCode = value,
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El código guía es obligatorio.';
                  }
                  return null;
                },
              ),
              CustomTextInput(
                  hintText: 'Fecha estimada de llegada',
                  icon: Icons.calendar_month_rounded,
                  onChanged: (value) =>
                      orderFormProvider.arrivelDate = int.parse(value),
                  keyboardType: TextInputType.datetime,
                  controller: _dataController
                    ..text = DateFormat('dd-MM-yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(order.arrivelDate)),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La fecha estimada de llega es obligatoria.';
                    }
                    return null;
                  },
                  onTap: () async {
                    await showDatePicker(
                        context: context,
                        initialDate:
                            DateTime.fromMillisecondsSinceEpoch(order.date),
                        firstDate:
                            DateTime.fromMillisecondsSinceEpoch(order.date),
                        lastDate: DateTime.now().add(const Duration(days: 100)),
                        locale: const Locale('es'),
                        builder: (BuildContext context, child) {
                          return Theme(
                              data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                primary: ColorStyle.mainRed,
                              )),
                              child: child!);
                        }).then((selectedDate) {
                      if (selectedDate != null) {
                        _dataController.text =
                            DateFormat('dd-MM-yyyy').format(selectedDate);
                        orderFormProvider.arrivelDate =
                            selectedDate.millisecondsSinceEpoch;
                      }
                    });
                  }),
              PrimaryButton(
                text: 'Aplicar cambio',
                onPressed: () {
                  _onFormSubmit(orderFormProvider, context, order);
                },
              ),
              SecundaryButton(
                  text: 'Regresar',
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        );
      },
    );
  }
}

void _onFormSubmit(
    OrderFormProvider orderFormProvider, context, Order order) async {
  if (orderFormProvider.validateForm()) {
    FirebaseRealtimeService.updateOrderCode(
            orderId: order.id,
            status: 3,
            shippingCode: orderFormProvider.shippingCode,
            arrivelDate: orderFormProvider.arrivelDate)
        .then((value) => Navigator.pushReplacementNamed(context, 'adminOrder'));
  } else {
    NotificationsService.showErrorSnackbar(
        'No se cumple con las condiciones mínimas para actualizar la información.');
  }
}
