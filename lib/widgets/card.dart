import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    this.user,
    this.order,
  }) : super(key: key);
  final User? user;
  final Order? order;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminUserProfileScreen(user: user!),
            ),
          );
        }
        if (order != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShipmentDetailScreen(order: order!),
            ),
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    if (user != null) ...{
                      _moldeRowInfo(
                          icon: Icons.person,
                          title: user!.name + ' ' + user!.lastname,
                          style: CustomTextStyle.robotoExtraBold),

                      _moldeRowInfo(
                          icon: Icons.email,
                          title: user!.email,
                          style: CustomTextStyle.robotoMedium),
                      // ,
                      _moldeRowInfo(
                          icon: Icons.phone,
                          title: user!.phone,
                          style: CustomTextStyle.robotoMedium),
                      _moldeRowInfo(
                          icon: MdiIcons.accountCog,
                          title: 'Rol: ',
                          style: CustomTextStyle.robotoMedium,
                          text: (user!.administrator)
                              ? 'Administrador'
                              : (user!.vendor)
                                  ? 'Vendedor'
                                  : 'Usuario')
                    },
                    if (order != null) ...{
                      _moldeRowInfo(
                          icon: MdiIcons.barcode,
                          title: order!.id,
                          style: CustomTextStyle.robotoExtraBold),

                      _moldeRowInfo(
                          icon: Icons.person,
                          title: order!.user['name'] +
                              ' ' +
                              order!.user['lastname'],
                          style: CustomTextStyle.robotoMedium),
                      // ,
                      _moldeRowInfo(
                          icon: Icons.calendar_month,
                          title: DateFormat('dd-MM-yyyy').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  order!.arrivelDate)),
                          style: CustomTextStyle.robotoMedium),
                      _moldeRowInfo(
                          icon: Icons.delivery_dining_rounded,
                          title: 'Estado: ',
                          style: CustomTextStyle.robotoMedium,
                          text: _getStatus(status: order!.status)),
                    }
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 40,
                  color: ColorStyle.textGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _getStatus({required int status}) {
  switch (status) {
    case 1:
      return 'En proceso';
    case 2:
      return 'Enviado';
    case 3:
      return 'En cammio';
    case 4:
      return 'Entregado';
    default:
      return 'En proceso';
  }
}

Padding _moldeRowInfo(
    {required IconData icon,
    required String title,
    required TextStyle style,
    String text = ''}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: Icon(
            icon,
            color: ColorStyle.mainRed,
            size: 30,
          ),
        ),
        Text(title, style: style),
        Text(
          text,
          style:
              CustomTextStyle.robotoMedium.copyWith(color: ColorStyle.mainBlue),
        ),
      ],
    ),
  );
}
