import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class CustomAppBarBackArrow extends StatelessWidget
    implements PreferredSizeWidget {
  ///Esta es la barra superrir que se encuentra en las pantalla más profundas de
  ///la nevegación. Disponde de una fleca para retroceder y un botón adicional que
  ///puede cambiar su acción o desactivarse, según la pantall lo nececite.
  const CustomAppBarBackArrow({
    Key? key,
    this.useActions = true,
    this.actionIcon,
    this.onPressed,
    this.navigatorOnPressed,
  }) : super(key: key);

  final bool useActions;
  final IconData? actionIcon;
  final void Function()? onPressed;
  final void Function()? navigatorOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 87,
      iconTheme: IconThemeData(color: ColorStyle.mainGrey),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: navigatorOnPressed,
        icon: const Icon(Icons.arrow_back),
        iconSize: 40,
      ),

      ///Evalua si es necesario el botón addicional o no, si lo es, construye el botón
      ///con su respectivo ícono, sinó no lo construye.
      actions: (useActions)
          ? [
              IconButton(
                onPressed: onPressed,
                icon: Icon(actionIcon),
                iconSize: 40,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
