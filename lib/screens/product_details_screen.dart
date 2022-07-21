import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/shared/preferences.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatefulWidget {
  ///Esta pantalla muestra la información básica del usuario correspondiente a su perfil
  ///junto con botones los cuales lo redirigen a más opciones de personalización relacionadas
  ///con su información personal.
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
            appBar: const CustomAppBar(),
            drawer: const CustomDrawer(),
            body: Scaffold(
              appBar: CustomAppBarBackArrow(
                editIcon: false,
                size: 41,
                icon: Icons.edit,
                iconColor1: Colors.black,
                actionIcon: Icons.delete_rounded,
                size1: 42,
                iconColor: Colors.red,
                onPressed: () {
                  //TODO: Realizar la funcion para vaciar el carrito.
                },
                navigatorOnPressed: () => Navigator.pop(context),
              ),
            )));
  }
}
