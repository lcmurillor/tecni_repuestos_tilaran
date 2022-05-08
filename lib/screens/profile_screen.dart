import 'package:flutter/material.dart';
import 'package:tecni_repuestos/theme/color_style.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

import '../theme/themes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
        body: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                child: Text(
                  'HL',
                  style: CustomTextStyle.robotoMedium
                      .copyWith(fontSize: 50, color: Colors.white),
                ),
                backgroundColor: ColorStyle.mainGrey,
                maxRadius: 58,
              ),
            ),
            const SizedBox(height: 20),
            Text('Nombre Completo del Usuario',
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
            Text('17-05-2022',
                style: CustomTextStyle.robotoExtraBold
                    .copyWith(fontSize: 15, color: Colors.grey[500])),
            const SizedBox(height: 7),
            CustomTextInput(
                hintText: 'Editar mi información',
                icon: Icons.edit,
                readOnly: true,
                onChanged: (value) => {},
                suffixIcon: Icons.arrow_forward_ios,
                keyboardType: TextInputType.emailAddress,
                //   onFieldSubmitted: (_) => onFormSubmit(loginFormProvider, context),
                validator: (value) {
                  // if (!EmailValidator.validate(value ?? '')) {
                  //   return 'Email no válido';
                  // } else {
                  //   return null;
                  // }
                }),
            CustomTextInput(
                hintText: 'Cambiar contraseña',
                icon: Icons.edit_note_rounded,
                readOnly: true,
                onChanged: (value) => {},
                suffixIcon: Icons.arrow_forward_ios,
                keyboardType: TextInputType.streetAddress,
                //   onFieldSubmitted: (_) => onFormSubmit(loginFormProvider, context),
                validator: (value) {
                  // if (!EmailValidator.validate(value ?? '')) {
                  //   return 'Email no válido';
                  // } else {
                  //   return null;
                  // }
                }),

            ///Input correspondiente a la contraseña solicitado para iniciar sesión.
            CustomTextInput(
                hintText: 'Gestionar Direcciones',
                icon: Icons.edit_location_alt_rounded,
                obscureText: false,
                readOnly: true,
                // onFieldSubmitted: (_) => onFormSubmit(loginFormProvider, context),
                onChanged: (value) => {},
                suffixIcon: Icons.arrow_forward_ios,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Ingrese su contraseña';
                  // }

                  // if (value.length < 6) {
                  //   return 'Debe tener más de 6 caractéres';
                  // }
                }
                //   return null;
                // }),
                // PrimaryButton(
                //     text: 'Iniciar sesión',
                //     onPressed: () => onFormSubmit(loginFormProvider, context)),
                // const SizedBox(height: 10),
                // SecundaryButton(
                //     text: '¿Olvidaste tu contraseña?',
                //     fontSize: 16,
                //     onPressed: () {}),
                )
          ],
        ),
      ),
    );
  }
}
