import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

///Correspode a una clase en la cual se hece llamado a diferentes cuadros de dialogo
///asociados a la dirreción de factuación o "userAddress", y la oportunidad de alterar
///los valores de una dirreción en particular. Se puede editar o añadir una dirrecion.
///Para ambos casos se reutiliza el formulario y sus respetivas validaciones.
class DialogAddress {
  ///Permite editar o añadir una dirrección de factuaración.
  static displayAddressDialog(BuildContext context, Address? address) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            title: Text(
              (address != null)
                  ? 'Editar una dirección de facturación'
                  : 'Añadir una dirreción de facturación',
              style: CustomTextStyle.robotoSemiBold.copyWith(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            content: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [AddressForm(address: address)],
              ),
            ),
          );
        });
  }
}

class AddressForm extends StatelessWidget {
  ///Éste widget correspoden al formulario que se usa tanto para añadir como para editar
  ///una dirreción de facturación "address". Si la dirección es enviada, se define como una actualización,
  ///sino, es una dirreción nuevalo que se busca hacer.
  const AddressForm({Key? key, this.address}) : super(key: key);
  final Address? address;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddressFormProvider(),
      child: Builder(builder: (context) {
        final addressFormProvider =
            Provider.of<AddressFormProvider>(context, listen: false);

        ///Este formulario evalua si se le entrega una objeto de tipo dirreción "address" y
        ///si es así, le asigna los valores a las cajas de texto, para que el usario edite
        ///únicamente lo que desea, además manda el objeto actualizado a la validación.
        ///Sinó se manda un objeto de tipo "address" se define como una dirección nueva.
        return Form(
          key: addressFormProvider.formKey,
          child: Column(
            children: [
              CustomTextInput(
                  controller: (address != null)
                      ? TextEditingController(text: address!.address)
                      : null,
                  hintText: 'Dirección exacta',
                  maxLines: 3,
                  icon: Icons.map,
                  onChanged: (value) => addressFormProvider.address = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La dirección exacta es obligatoria.';
                    }
                    return null;
                  }),
              CustomTextInput(
                  controller: (address != null)
                      ? TextEditingController(text: address!.canton)
                      : null,
                  hintText: 'Cantón',
                  icon: MdiIcons.mapMarker,
                  onChanged: (value) => addressFormProvider.canton = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El Cantón es obligatorio.';
                    }
                    return null;
                  }),
              CustomTextInput(
                  controller: (address != null)
                      ? TextEditingController(text: address!.province)
                      : null,
                  hintText: 'Provincia',
                  icon: MdiIcons.mapMarker,
                  onChanged: (value) => addressFormProvider.province = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La Provincia es obligatoria.';
                    }
                    return null;
                  }),
              const SizedBox(height: 5),
              PrimaryButton(
                  text: 'Aplicar cambio',
                  onPressed: () {
                    if (address == null) {
                      _onFormSubmit(addressFormProvider, context);
                    } else {
                      _onFormSubmit(addressFormProvider, context,
                          address: address);
                    }
                  }),
              SecundaryButton(
                  text: 'Regresar', onPressed: () => Navigator.pop(context))
            ],
          ),
        );
      }),
    );
  }
}

///Evalua si el formulario cumple con las codiciones mínimas para ser aceptado, además
///que se cumplan con las validaciónes de los datos en la base de datos. Para los campos
///que no sean alterados por el usuario, asigna nuevamente los valores ya definidos y navega
///a la pantalla anterior.
void _onFormSubmit(AddressFormProvider addressFormProvider, context,
    {Address? address}) async {
  if (address == null) {
    ///Si se espera crear una nueva dirección de facturación, la condición entra acá
    ///y se toman unicamente los valores de FormProvider, ya que a este punto, un objeto de tipo "address" no existe.
    if (addressFormProvider.validateForm()) {
      final _address = Address(
          address: addressFormProvider.address,
          canton: addressFormProvider.canton,
          id: 'undefined',
          province: addressFormProvider.province,
          userId: FirebaseAuthService.auth.currentUser!.uid,
          last: true);
      FirebaseRealtimeService.setAddress(address: _address, context: context);
    } else {
      NotificationsService.showErrorSnackbar(
          'No se cumple con las condiciones mínimas para agregar la dirección.');
    }
  } else {
    ///Si un objeto de tipo address existe, se entiendo como que lo que se busca es
    ///actualizar los datos de este objeto y por lo tanto se entra a esta condición.
    Future.delayed(Duration.zero, () {
      if (addressFormProvider.validateForm()) {
        address = Address(
            address: (addressFormProvider.address == "")
                ? address!.address
                : addressFormProvider.address,
            canton: (addressFormProvider.canton == "")
                ? address!.canton
                : addressFormProvider.canton,
            id: address!.id,
            province: (addressFormProvider.province == "")
                ? address!.province
                : addressFormProvider.province,
            userId: address!.userId,
            last: true);
      } else {
        NotificationsService.showErrorSnackbar(
            'No se cumple con las condiciones mínimas para actualizar la información.');
      }
    }).then((value) {
      FirebaseRealtimeService.updateAddress(
          address: address!, context: context);
    });
  }
}
