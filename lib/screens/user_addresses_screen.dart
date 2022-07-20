import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/card_address.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class UserAddressesScreen extends StatelessWidget {
  ///En esta pantalla se almacenan y se gestionan las direcciones físicas del usuario
  ///las cuales se utilizan para identifiar el destino de los paquetes que solicite mediante la Aplicación.
  ///Se pueden editar, eliminar, ver y agregar direciones para el usuario actualmente registrado.
  const UserAddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarBackArrow(
            useActions: false,
            navigatorOnPressed: () => Navigator.pop(context)),
        body: Column(children: [
          const SizedBox(height: 50),
          Text('Direcciones de facturación',
              style: CustomTextStyle.robotoSemiBold.copyWith(fontSize: 27)),
          const SizedBox(height: 40),
          Expanded(
            child: Stack(
              children: [
                ///Construción de la lista de direcciones asociadas al usuario activo.
                FirebaseAnimatedList(
                  ///Resive la consulta de la base de datos.
                  query: FirebaseRealtimeService.getAddressesByUser(
                      uid: FirebaseAuthService.auth.currentUser!.uid),
                  defaultChild: const CustomProgressIndicator(),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, snapshot, animation, index) {
                    if (!snapshot.exists) {
                      return NotificationsService.showErrorSnackbar(
                          'Ha ocurrido un error a la hora de cargar los datos.');
                    }
                    final address =
                        Address.fromMap(jsonDecode(jsonEncode(snapshot.value)));

                    return CardAddress(address: address);
                  },
                ),

                ///Botón en la parte inferior con el cual se agregan dirrecciones.
                Positioned(
                  bottom: 30,
                  left: 20,
                  child: FloatingActionButton(
                    backgroundColor: ColorStyle.mainRed,
                    child: const Icon(
                      Icons.add,
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () =>
                        DialogAddress.displayAddressDialog(context, null),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
