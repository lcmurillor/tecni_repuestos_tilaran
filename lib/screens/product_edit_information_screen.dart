import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/shared/preferences.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class ProductEditInformationScreen extends StatelessWidget {
  const ProductEditInformationScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
      useBackArrow: true,
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text('Editar producto',
                          style: CustomTextStyle.robotoSemiBold
                              .copyWith(fontSize: 30)),
                      const SizedBox(height: 15),
                      _EditInfoForm(product: product),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 45)
            ],
          )),
    ));
  }
}

class _EditInfoForm extends StatelessWidget {
  const _EditInfoForm({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditInfoProductProvider(),
      child: Builder(builder: (context) {
        final editInfoProductProvider =
            Provider.of<EditInfoProductProvider>(context, listen: false);

        return Form(
          key: editInfoProductProvider.formKey,
          child: Column(
            children: [
              CustomTextInput(
                  controller: TextEditingController(text: product.description),
                  hintText: 'Nombre del producto',
                  icon: Icons.person,
                  onChanged: (value) =>
                      editInfoProductProvider.description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    } else if (value.length < 2) {
                      return 'EL nombre debe tener 2 o más caracteres.';
                    }
                    return null;
                  }),
              CustomTextInput(
                  controller: TextEditingController(text: product.code),
                  hintText: 'Código',
                  icon: Icons.numbers,
                  onChanged: (value) => editInfoProductProvider.code = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El apellido es obligatorio';
                    } else if (value.length < 2) {
                      return 'El apellido debe tener 2 o más caracteres.';
                    }
                    return null;
                  }),
              CustomTextInput(
                  controller:
                      TextEditingController(text: product.cost.toString()),
                  hintText: 'Costo',
                  icon: Icons.monetization_on,
                  onChanged: (value) => editInfoProductProvider.cost = value,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El costo es obligatorio.';
                    } else if (value.length < 3) {
                      return 'El costo no es valido.';
                    }
                    return null;
                  }),
              CustomTextInput(
                  controller: TextEditingController(text: product.location),
                  hintText: 'Localización',
                  icon: Icons.location_on,
                  onChanged: (value) =>
                      editInfoProductProvider.location = value,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La localización es obligatoria.';
                    } else if (value.length < 2) {
                      return 'La localización no es válida.';
                    }
                    return null;
                  }),
              CustomTextInput(
                  controller: TextEditingController(text: product.category),
                  hintText: 'Categoría',
                  icon: Icons.category,
                  onChanged: (value) =>
                      editInfoProductProvider.category = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    } else if (value.length < 2) {
                      return 'EL nombre debe tener 2 o más caracteres.';
                    }
                    return null;
                  }),
              DropdownButtonFormField<String>(
                style: CustomTextStyle.robotoSemiBold.copyWith(
                    color:
                        (Preferences.isDarkmode) ? Colors.white : Colors.black),
                borderRadius: BorderRadius.circular(10),
                decoration:
                    InputStyle.mainInput(hintText: '', icon: Icons.settings),
                value:
                    'spare', //Este será el valor por defecto al dibujar el widget
                items: const [
                  DropdownMenuItem(
                    value: 'spare',
                    child: Text('Repuesto'),
                  ),
                  DropdownMenuItem(
                    value: 'accesorie',
                    child: Text('Accesorio'),
                  ),
                ],
                onChanged: (value) {
                  editInfoProductProvider.type = value.toString();
                },
              ),
              const SizedBox(height: 15),
              CustomTextInput(
                  controller:
                      TextEditingController(text: product.price.toString()),
                  hintText: 'Precio',
                  icon: Icons.price_check,
                  onChanged: (value) => editInfoProductProvider.price = value,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El precio es obligatorio.';
                    } else if (value.length < 2) {
                      return 'El precio no es valido.';
                    }
                    return null;
                  }),
              CustomTextInput(
                  controller:
                      TextEditingController(text: product.quantity.toString()),
                  hintText: 'Disponibles',
                  icon: Icons.format_list_numbered_outlined,
                  onChanged: (value) =>
                      editInfoProductProvider.quantity = value,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El cantidad es obligatoria.';
                    }
                    return null;
                  }),
              const SizedBox(height: 5),
              PrimaryButton(
                  text: 'Aplicar cambio',
                  onPressed: () =>
                      _onFormSubmit(editInfoProductProvider, context, product))
            ],
          ),
        );
      }),
    );
  }
}

///Evalua si el formulario cumple con las condiciones mínimas para ser aceptado, además
///de que se cumplan con las validaciónes de los datos en la base de datos. Para los campos
///que no sean alterados por el usuario, asigna nuevamente los valores ya definidos y navega
///a la pantalla anterior.
void _onFormSubmit(EditInfoProductProvider editInfoFormProductProvider, context,
    Product product) async {
  Future.delayed(Duration.zero, () {
    if (editInfoFormProductProvider.validateForm()) {
      product = Product(
          description: (editInfoFormProductProvider.description == '')
              ? product.description
              : editInfoFormProductProvider.description,
          code: (editInfoFormProductProvider.code == '')
              ? product.code
              : editInfoFormProductProvider.code,
          cost: (editInfoFormProductProvider.cost == '')
              ? product.cost
              : double.parse(editInfoFormProductProvider.cost),
          location: (editInfoFormProductProvider.location == '')
              ? product.location
              : editInfoFormProductProvider.location,
          type: (editInfoFormProductProvider.type == '')
              ? product.type
              : editInfoFormProductProvider.type,
          price: (editInfoFormProductProvider.price == '')
              ? product.price.toDouble()
              : double.parse(editInfoFormProductProvider.price),
          quantity: (editInfoFormProductProvider.quantity == '')
              ? product.quantity.toInt()
              : int.parse(editInfoFormProductProvider.quantity),
          id: product.id,
          category: (editInfoFormProductProvider.category == '')
              ? product.category
              : editInfoFormProductProvider.category,
          imageUrl: product.imageUrl);
    } else {
      NotificationsService.showErrorSnackbar(
          'No se cumple con las condiciones mínimas para actualizar la información.');
    }
  }).then((value) {
    FirebaseRealtimeService.updateProduct(product: product);
    if (editInfoFormProductProvider.validateForm()) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product)));
      NotificationsService.showSnackbar(
          'Información actualizada correctamente.');
    }
  });
}
