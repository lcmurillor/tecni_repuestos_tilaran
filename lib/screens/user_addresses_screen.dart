import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class UserAddressesScreen extends StatelessWidget {
  ///En esta pantalla se almacenan y se gestionan las direcciones físicas del usuario
  ///las cuales se utilizan para identifiar el destino de los paquetes que solicite mediante la Aplicación.
  ///Se pueden editar, eliminar, ver y agregar direciones para el usuario actualmente registrado.
  const UserAddressesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentScreen = Provider.of<ComeFromProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, currentScreen.getScreen());
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBarBackArrow(
              useActions: false,
              navigatorOnPressed: (currentScreen.getScreen() == 'profile')
                  ? () => Navigator.pushReplacementNamed(context, 'profile')
                  : () => Navigator.pushReplacementNamed(context, 'myCart')),
          body: Column(children: [
            const SizedBox(height: 50),
            Text('Direcciones de facturación',
                style: CustomTextStyle.robotoSemiBold.copyWith(fontSize: 27)),
            const SizedBox(height: 40),
            Expanded(
              child: Stack(
                children: [
                  FutureBuilder(
                    ///Conexión a la base de datos para crear la lista de dirreciones
                    future: FirebaseRealtimeService.getAddressesByUser(
                        uid: FirebaseAuthService.auth.currentUser!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Address>> snapshot) {
                      if (snapshot.hasError) {
                        return NotificationsService.showErrorSnackbar(
                            'Ha ocurrido un error a la hora de cargar los datos.');
                      }

                      if (!snapshot.hasData) {
                        return const CustomProgressIndicator();
                      }

                      final address = snapshot.data!;

                      if (address.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text(
                              'Actualmente no tiene direcciones registradas. Por favor, agregue una dirección de facturación.',
                              style: CustomTextStyle.robotoSemiBold.copyWith(
                                  fontSize: 20, color: ColorStyle.textGrey),
                              textAlign: TextAlign.center),
                        );
                      }

                      ///Contruye una lista de card en los cuales se presenta las direcciones.
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: address.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (currentScreen.getScreen() == 'myCart') {
                                  FirebaseRealtimeService.updateLastAddress(
                                      address: address[index],
                                      context: context);
                                }
                              },
                              child: CardAddress(address: address[index]));
                        },
                      );
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
                      onPressed: () async =>
                          DialogAddress.displayAddressDialog(context, null),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
