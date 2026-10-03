import 'package:flutter/material.dart';

class CustomAppBarBackArrow extends StatelessWidget
    implements PreferredSizeWidget {
  ///Este widget corresponde a una barra (invisible) en la parte superir, que es utilizado en algunas pantallas
  ///para permitir la navegación a pantallas anterires. Disponde de una flecha para retroceder y un botón adicional que
  ///puede cambiar su acción o desactivarse, según la pantalla lo necesite.
  const CustomAppBarBackArrow({
    super.key,
    this.editIcon = true,
    this.useActions = true,
    this.icon,
    this.actionIcon,
    this.onPressed,
    this.navigatorOnPressed,
    this.iconColor1,
    this.iconColor,
    this.size = 26,
    this.size1 = 26,
  });
  final bool editIcon;
  final bool useActions;
  final IconData? icon;
  final IconData? actionIcon;
  final Color? iconColor1;
  final Color? iconColor;
  final double size;
  final double size1;
  final void Function()? onPressed;
  final void Function()? navigatorOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      iconTheme: IconThemeData(color: iconColor),

      elevation: 0,

      leading: (editIcon)
          ? IconButton(
              onPressed:
                  navigatorOnPressed ?? () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_outlined),
              iconSize: size,
            )
          : IconButton(
              onPressed:
                  navigatorOnPressed ?? () => Navigator.maybePop(context),
              icon: Icon(icon, color: iconColor1),
              iconSize: size,
            ),

      ///Evalua si es necesario el botón addicional o no, si lo es, construye el botón
      ///con su respectivo ícono, sinó no lo construye.
      actions: (useActions)
          ? [
              IconButton(
                onPressed: onPressed,
                icon: Icon(actionIcon, color: iconColor),
                iconSize: size1,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
