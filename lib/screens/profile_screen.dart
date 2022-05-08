import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //TODO corregist el tamaño del addbar
        appBar: AppBar(
          toolbarHeight: 87,
          iconTheme: IconThemeData(color: ColorStyle.mainGrey),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
            iconSize: 40,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.dark_mode),
              iconSize: 40,
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseCloudService.getUserByUid(
              FirebaseAuthService.auth.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.hasError) {
              return NotificationsService.showSnackbar(
                  'Ha ocurrido un error a la hora de cargar los datos.');
            }

            if (!snapshot.hasData) {
              return const CustomProgressIndicator();
            }

            final user = snapshot.data!;
            return Column(
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    child: Text(
                      //TODO Seleccionar solo la prinmera lera de nombre y apellido
                      user[0].name,
                      style: CustomTextStyle.robotoMedium
                          .copyWith(fontSize: 50, color: Colors.white),
                    ),
                    backgroundColor: ColorStyle.mainGrey,
                    maxRadius: 58,
                  ),
                ),
                const SizedBox(height: 20),
                Text(user[0].name + ' ' + user[0].lastname,
                    style: CustomTextStyle.robotoExtraBold
                        .copyWith(fontSize: 20, color: Colors.black)),
                const SizedBox(
                  height: 7,
                ),
                Text('dirección@correo.com',
                    style: CustomTextStyle.robotoSemiBold
                        .copyWith(fontSize: 15, color: Colors.grey[500])),
                const SizedBox(
                  height: 7,
                ),
                Text('+50688888888',
                    style: CustomTextStyle.robotoSemiBold
                        .copyWith(fontSize: 16, color: ColorStyle.mainRed)),
                const SizedBox(
                  height: 7,
                ),
                Text(user[0].birthdate.toString(),
                    style: CustomTextStyle.robotoExtraBold
                        .copyWith(fontSize: 15, color: Colors.grey[500])),
                const SizedBox(height: 20),
                //TODO agregar iconos mas adecuados no impor la libreria
                _CustomInfoButton(
                  icon: MdiIcons.accountEdit,
                  onPressed: () {
                    //TODO crearo los metodos de navegacion
                    print("Esto es un boton 1 ");
                  },
                  text: 'Edtar mi información',
                ),
                _CustomInfoButton(
                  icon: MdiIcons.formTextboxPassword,
                  onPressed: () {
                    print("Esto es un boton 2 ");
                  },
                  text: 'Cambiar mi contraseña',
                ),
                _CustomInfoButton(
                  icon: MdiIcons.mapPlus,
                  onPressed: () {
                    print("Esto es un boton 3 ");
                  },
                  text: 'Gestionar Dirrecciones',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

//TODO comvertit en un Widget goblal
class _CustomInfoButton extends StatelessWidget {
  const _CustomInfoButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final void Function()? onPressed;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
          //TODO agreegar el estilo correcto a los botonos
          child: Container(
              width: size.width * 0.75,
              height: size.width * 0.12,
              color: ColorStyle.buttonGray,
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 0, right: 10),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: ColorStyle.mainRed),
                        child: Icon(
                          icon,
                          size: 18,
                          color: Colors.white,
                        ),
                      )),
                  Expanded(
                    child: Text(text,
                        style: CustomTextStyle.robotoMedium.copyWith(
                            fontSize: 18, color: ColorStyle.textGrey)),
                  ),
                  FaIcon(
                    //TODO este icono deve llegar como una variable
                    FontAwesomeIcons.chevronRight,
                    size: 30,
                    color: ColorStyle.textGrey,
                  ),
                ],
              )),
          onTap: onPressed),
    );
  }
}
