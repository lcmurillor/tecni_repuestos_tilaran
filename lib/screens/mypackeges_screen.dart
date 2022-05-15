import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

import '../theme/themes.dart';

class MyPackegesScreen extends StatelessWidget {
  const MyPackegesScreen({Key? key, this.hasError = false}) : super(key: key);
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
                Center(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 30.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        width: 280,
                        height: 35,
                        child: TextField(
                            onTap: () {},
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: inputDecoration()))),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'home'),
                  child: CardContainer(
                    child: Column(
                      children: [
                        moldeRowInfo(
                            const EdgeInsets.fromLTRB(20, 10, 10, 9),
                            MdiIcons.barcode,
                            'CR452687230WS',
                            CustomTextStyle.robotoExtraBold),
                        moldeRowInfo(
                            const EdgeInsets.fromLTRB(20, 0, 10, 5),
                            Icons.person,
                            'Nombre completo del usuario',
                            CustomTextStyle.robotoMedium),
                        moldeRowInfo(
                            const EdgeInsets.fromLTRB(20, 5, 10, 5),
                            Icons.calendar_today_rounded,
                            '25/11/2022',
                            CustomTextStyle.robotoMedium),
                        // ,

                        moldeRowInfo(
                            const EdgeInsets.fromLTRB(20, 5, 10, 5),
                            MdiIcons.truckDelivery,
                            'Estado: ',
                            CustomTextStyle.robotoMedium,
                            'En camino')
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ));
    });
  }

  Row moldeRowInfo(
      EdgeInsetsGeometry padding, IconData icon, String text, TextStyle style,
      [String text2 = '']) {
    return Row(
      children: [
        Padding(
          padding: padding,
          child: Icon(
            icon,
            color: Colors.redAccent[700],
            size: 30,
          ),
        ),
        Text(text, style: style),
        Text(
          text2,
          style:
              CustomTextStyle.robotoMedium.copyWith(color: ColorStyle.mainBlue),
        ),
      ],
    );
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
        'El ususario indicado no está registrado.');
  }
}

InputDecoration inputDecoration() {
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
