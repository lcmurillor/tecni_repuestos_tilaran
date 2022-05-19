import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
//import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../theme/themes.dart';

class ShipmentDetailScreen extends StatelessWidget {
  const ShipmentDetailScreen({Key? key, this.hasError = false})
      : super(key: key);
  final bool hasError;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      Future.delayed(Duration.zero, () {
        if (hasError) {
          NotificationsService.showErrorSnackbar(
              'Ha ocurrido un error en sus paquetes.');
        }
      });
      return Scaffold(
          body: Background(
        useBackArrow: true,
        useImg: false,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 110),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'shipment'),
                  child: CardContainer(
                    child: Column(
                      children: [
                        Text('Detalles del envío',
                            style: CustomTextStyle.robotoMedium
                                .copyWith(fontSize: 30)),
                        Row(children: [
                          Text(
                            'Fecha estimada de llegada: ',
                            style: CustomTextStyle.robotoExtraBold
                                .copyWith(height: 3),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
                            child: Text(
                              '05-05-2022',
                              style: CustomTextStyle.robotoSemiBold
                                  .copyWith(color: Colors.black38),
                            ),
                          )
                        ]),
                        Row(children: [
                          Text(
                            'Medio de envío: ',
                            style: CustomTextStyle.robotoExtraBold
                                .copyWith(height: 2),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(
                              'Correos de Costa Rica',
                              style: CustomTextStyle.robotoSemiBold
                                  .copyWith(color: Colors.black38),
                            ),
                          )
                        ]),
                        Row(children: [
                          Text(
                            'Código guía: ',
                            style: CustomTextStyle.robotoExtraBold
                                .copyWith(height: 2),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(
                              'WR34542658CR',
                              style: CustomTextStyle.robotoSemiBold
                                  .copyWith(color: Colors.black38),
                            ),
                          )
                        ]),
                        Stack(children: [
                          SizedBox(
                            height: 200,
                            child: FAProgressBar(
                              borderRadius: null,
                              size: 10,
                              backgroundColor: Colors.black12,
                              //progressColor: Colors.pink,
                              changeColorValue: 5,
                              changeProgressColor: Colors.green,
                              currentValue: 10,
                              maxValue: 100,
                              direction: Axis.vertical,
                              verticalDirection: VerticalDirection.down,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            child: Text('Estado',
                                style: CustomTextStyle.robotoSemiBold
                                    .copyWith(fontSize: 25, height: 2)),
                          ),
                          Positioned(
                            top: 50,
                            right: 40,
                            child: Text('Etapa',
                                style: CustomTextStyle.robotoSemiBold
                                    .copyWith(fontSize: 25, height: 2)),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ));
    });
  }
}

///Función intermedia que hace una llamado a la base de datos para optener un usuario
///si éste está registrado, de ahí se hacen el resto de evaluaciones de autetificación.
void _onFormSubmit(LoginFormProvider loginFormProvider, BuildContext context) {
  FirebaseCloudService.getUserByEmail(loginFormProvider.email).then(
      (UserModel? user) => _validateData(user, loginFormProvider, context));
}

///Función de evalución final, evalua que el formulario cumpla con los requerimientos
///mínimos y si el usuario registrado está activo en el sistema. Si se cumplen las condiciones
///se puede iniciar la sesión.
void _validateData(UserModel? user, LoginFormProvider loginFormProvider,
    BuildContext context) {
  final isValid = loginFormProvider.validateForm();
  if (null != user && !user.disabled && isValid) {
    FirebaseAuthService.signIn(
        loginFormProvider.email, loginFormProvider.password, context);
  } else {
    NotificationsService.showErrorSnackbar(
        'El usuario indicado no está registrado.');
  }
}

InputDecoration inputDecorations() {
  return InputDecoration(
      prefixStyle: GoogleFonts.roboto(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      hintText: 'Busca un paquete',
      hintStyle: GoogleFonts.roboto(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      prefixIcon: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SvgPicture.asset(
            'assets/search.svg',
            fit: BoxFit.contain,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent)));
}
