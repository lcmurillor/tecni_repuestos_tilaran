import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsScreen extends StatelessWidget {
  ///Ésta pantalla muestra la información general de la tienda, horario, ubicación e información
  ///de contacto, junto con botones los cuales facilitan los métodos de contacto.
  const AboutUsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mainTheme = Provider.of<ThemeProvider>(context).currentTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
            useImg: false,
            useBackArrow: true,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ///Corresponde el espacio en la parte superior para centrar el card.
                    SizedBox(height: size.height * 0.15),
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(children: [
                        const SizedBox(height: 10),

                        SvgPicture.asset(
                          (mainTheme == MainTheme.darkTheme)
                              ? 'assets/logo-full-white-red.svg'
                              : 'assets/logo-red.svg',
                          fit: BoxFit.cover,
                          height: 80,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: const Image(
                            image: AssetImage('assets/tecni-repuestos.jpg'),
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _info(Icons.mail, 'tecnirepuestostilaran@gmail.com',
                            size, mainTheme),
                        _info(Icons.map, '280 mts norte del Banco Nacional',
                            size, mainTheme),
                        _info(Icons.watch_later_rounded,
                            'Lunes a Viernes 8:00am a 6:00pm', size, mainTheme),
                        _info(Icons.phone, '2695-5837', size, mainTheme),
                        const SizedBox(height: 10),

                        ///Botón para llamar a la tienda, al ser precionado debe salir de la aplicación
                        ///y enviar el número de teléfono al apartado de llamdas del usuario para que llame a
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
                      ]),
                    )),
                  ],
                ))));
  }

  /// Permite cargar una fila en la cuel se encuenta in icono y un texto el cual es enciado por parámetro.
  Padding _info(IconData icon, String text, Size size, ThemeData mainTheme) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Row(children: [
          Icon(
            icon,
            color: mainTheme.colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Text(text,
              style: CustomTextStyle.robotoSemiBold
                  .copyWith(fontSize: size.width * 0.04))
        ]));
  }
}
