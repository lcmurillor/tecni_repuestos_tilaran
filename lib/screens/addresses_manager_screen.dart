import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/card_address.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class AddressesManagerScreen extends StatelessWidget {
  const AddressesManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBackArrow(
          useActions: false, navigatorOnPressed: () => Navigator.pop(context)),
      body: Column(children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        Text('Dirrecciones de facturación',
            style: CustomTextStyle.robotoSemiBold.copyWith(fontSize: 27)),
        const SizedBox(
          height: 40,
          width: double.infinity,
        ),
        Expanded(
          child: Stack(
            children: [
              StreamBuilder(
                stream: FirebaseCloudService.getAddressesByUser(
                    FirebaseAuthService.auth.currentUser!.uid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return NotificationsService.showErrorSnackbar(
                        'Ha ocurrido un error a la hora de cargar los datos.');
                  }

                  if (!snapshot.hasData) {
                    return const CustomProgressIndicator();
                  }

                  final data = snapshot.data!;

                  if (data.length == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text(
                          'Actualmente no tiene dirreciones registradas. Por favor, agregue una dirreción de facturación.',
                          style: CustomTextStyle.robotoSemiBold.copyWith(
                              fontSize: 20, color: ColorStyle.textGrey),
                          textAlign: TextAlign.center),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return const AddressCard();
                    },
                  );
                },
              ),
              Positioned(
                bottom: 30,
                right: 20,
                child: FloatingActionButton(
                  backgroundColor: ColorStyle.mainRed,
                  child: const Icon(Icons.add, size: 50),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
