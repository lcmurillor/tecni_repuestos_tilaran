import 'package:flutter/material.dart';

class CustomAppBarBackArrow extends StatelessWidget
    implements PreferredSizeWidget {
  ///Este widget corresponde a una barra (invisible) en la parte superir, que es utilizado en algunas pantallas
  ///para permitir la navegación a pantallas anterires. Disponde de una flecha para retroceder y un botón adicional que
  ///puede cambiar su acción o desactivarse, según la pantalla lo necesite.
  const CustomAppBarBackArrow({
    Key? key,
    this.useActions = true,
    this.actionIcon,
    this.onPressed,
    this.navigatorOnPressed,
    this.iconColor,
  }) : super(key: key);

  final bool useActions;
  final IconData? actionIcon;
  final Color? iconColor;
  final void Function()? onPressed;
  final void Function()? navigatorOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 87,
      iconTheme: IconThemeData(color: iconColor),
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
                icon: Icon(actionIcon, color: iconColor),
                iconSize: 40,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
