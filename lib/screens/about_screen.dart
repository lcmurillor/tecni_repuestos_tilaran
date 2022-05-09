import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsScreen extends StatelessWidget {
  ///Ésta pantalla muestra la información general de la tienda, horario, ubicación e información
  ///de contacto, junto con botones los cuales facilitan los metodos de contacto.
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
            useImg: false,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.10),
                    CardContainer(
                        child: Column(children: [
                      const SizedBox(height: 10),
                      SvgPicture.asset(
                        'assets/logo-red.svg',
                        fit: BoxFit.cover,
                        height: 80,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: const Image(
                          image: AssetImage('assets/tecni-repuestos.jpg'),
                          fit: BoxFit.cover,
                          height: 250,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _info(
                          Icons.mail, 'tecnirepuestostilaran@gmail.com', size),
                      _info(
                          Icons.map, '280 mts norte del Banco Nacional', size),
                      _info(Icons.watch_later_rounded,
                          'Lunes a Viernes 8:00am a 6:00pm', size),
                      _info(Icons.phone, '2695-5837', size),
                      const SizedBox(height: 10),

                      ///Botón para llamar a la tienda, al ser precionado debe salir de la aplicación
                      ///y enviar el número de telefono al apartado de llamdas del usario para que llame a
                      ///la tienda.
                      PrimaryButton(
                          text: 'Llamar',
                          onPressed: () async {
                            const String phone = 'tel:+50626955837';
                            if (await canLaunchUrlString(phone)) {
                              await launchUrlString(phone);
                            }
                          }),

                      ///Botón para enviar un correo, al ser precionado, debe salir de la aplicación y
                      ///abrir el cliente de correos electronicos para empezar a redactar un correo a la tienda.
                      SecundaryButton(
                          text: 'Enviar un correo',
                          onPressed: () async {
                            const String emial =
                                'mailto:tecnirepuestostilaran@gmail.com?subject=Consulta&body=Saludos\nTengo una consulta:\n';
                            if (await canLaunchUrlString(emial)) {
                              await launchUrlString(emial);
                            }
                          })
                    ])),
                  ],
                ))));
  }

  /// Permite cargar una fila en la cuel se encuenta in icono y un texto el cual es enciado por parámetro.
  Padding _info(IconData icon, String text, Size size) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Row(children: [
          Icon(
            icon,
            color: ColorStyle.mainRed,
          ),
          const SizedBox(width: 10),
          Text(text,
              style: CustomTextStyle.robotoSemiBold
                  .copyWith(fontSize: size.width * 0.04))
        ]));
  }
}
