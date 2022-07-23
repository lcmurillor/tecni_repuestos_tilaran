import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/dialog_address.dart';

class CardAddress extends StatelessWidget {
  ///Éste widget es un card personalizado el cual es usado para mostrar de manera cómoda
  ///los datos de las diferentes direcciones guardadas por un usuario y junto con estos datos,
  ///las opciones de editar o eliminar la información.
  const CardAddress({Key? key, required this.address}) : super(key: key);
  final Address address;

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
                    '${address.canton}, ${address.province}.',
                    style: CustomTextStyle.robotoMedium.copyWith(fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    address.address,
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
                ///Botón para editar la dirreción del facturación.
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 40,
                    color: ColorStyle.mainGreen,
                  ),
                  onPressed: () async =>
                      DialogAddress.displayAddressDialog(context, address),
                ),

                ///Botón para eliminar la dirreción de faturación.
                IconButton(
                    icon: Icon(MdiIcons.deleteForever,
                        size: 40, color: ColorStyle.mainRed),
                    onPressed: () => NotificationsService.displayDeleteDialog(
                            context,
                            '¿Está seguro que desea eliminar la dirrección: ${address.address}?',
                            () {
                          FirebaseRealtimeService.deleteAddress(
                              key: address.id);
                          Navigator.popAndPushNamed(context, 'addresses');
                        })),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
