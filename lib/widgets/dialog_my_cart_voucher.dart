// import 'package:file_picker/file_picker.dart'; // Cargas deshabilitadas.
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class DialogMyCartVoucher {
  static displayMyCartVoucherDialog(
      {required BuildContext context, required String code}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: AlertDialog(
              elevation: 10,
              title: Text(
                'Enviar comprobante',
                style: CustomTextStyle.robotoSemiBold.copyWith(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'Adjunte el comprobante de pago por concepto de orden $code para iniciar el proceso de tramitar su compra.',
                        style: CustomTextStyle.robotoSemiBold,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    PrimaryButton(
                      text: 'Agregar imagen',
                      onPressed: () async {
                        if (DemoAuthService.auth.currentUser != null) {
                          DemoStorageService.notice();
// final result = await FilePicker.platform.pickFiles(
//                               allowMultiple: false,
//                               type: FileType.custom,
//                               allowedExtensions: ['png', 'jpg']);
//                           if (result == null) {
//                             NotificationsService.showSnackbar(
//                                 'No ha selecionado ninguna imagen.');
//                           } else {
//                             final path = result.files.single.path;
//                             final name = code;
//                             DemoStorageService.uploadOrderFile(path!, name)
//                                 .then((value) => LocalDataService
//                                         .updateOrderStatus(
//                                             orderId: name, status: 1)
//                                     .then((value) =>
//                                         LocalDataService.deleteUserCart()
//                                             .then((value) =>
//                                                 Navigator.pushReplacementNamed(
//                                                     context, 'myOrder'))));
//                           }

                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    PrimaryButton(
                      color: ColorStyle.textGrey,
                      text: 'Continuar sin imagen',
                      onPressed: () async {
                        if (DemoAuthService.auth.currentUser != null) {
                          LocalDataService.updateOrderStatus(
                                  orderId: code, status: 1)
                              .then((value) =>
                                  LocalDataService.deleteUserCart().then(
                                      (value) => Navigator.pushReplacementNamed(
                                          context, 'myOrder')));
                        }
                      },
                    ),
                    SecundaryButton(
                        text: 'Regresar',
                        onPressed: () => Navigator.pop(context))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
