import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/screens/ui/input_decorations.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
              body: Background(
            useImg: true,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 180),
                    CardContainer(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Iniciar Sesion',
                              style: GoogleFonts.roboto(
                                  fontSize: size.width * 0.11,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 30,
                          ),
                          _LoginForm()
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 70),
                            child: Text(
                              '¿No tienes cuenta?',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Regístrate ahora',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color:
                                        const Color.fromRGBO(0, 152, 181, 1)),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ));
        }));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthProvicer firebaseAuthProvicer =
        Provider.of<FirebaseAuthProvicer>(context);
    final size = MediaQuery.of(context).size;
    final loginFormProvider =
        Provider.of<LoginFormProvider>(context, listen: false);
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: loginFormProvider.formKey,
      child: Column(
        children: [
          //email
          TextFormField(
            onFieldSubmitted: (_) =>
                onFormSubmit(loginFormProvider, firebaseAuthProvicer, context),
            validator: (value) {
              if (!EmailValidator.validate(value ?? '')) {
                return 'Email no válido';
              } else {
                return null;
              }
            },
            onChanged: (value) => loginFormProvider.email = value,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Correo Electrónico', icon: Icons.email),
          ),
          const SizedBox(height: 30),
          //password
          TextFormField(
            onFieldSubmitted: (_) =>
                onFormSubmit(loginFormProvider, firebaseAuthProvicer, context),
            onChanged: (value) => loginFormProvider.password = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su contraseña';
              }
              if (value.length < 6) {
                return 'Debe tener más de 6 caractéres';
              }
              return null;
            },
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginScreen(
                hintText: 'Contraseña', icon: Icons.lock),
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              disabledColor: Colors.grey,
              color: const Color.fromRGBO(214, 39, 31, 1),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                child: Text(
                  'Iniciar sesión',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onPressed: () {
                onFormSubmit(loginFormProvider, firebaseAuthProvicer, context);
              }),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: const Color.fromRGBO(0, 152, 181, 1)),
            ),
          ),
          const SizedBox(height: 14)
        ],
      ),
    );
  }

  void onFormSubmit(LoginFormProvider loginFormProvider,
      FirebaseAuthProvicer authentication, context) {
    final isValid = loginFormProvider.validateForm();

    if (isValid) {
      authentication.signIn(
          loginFormProvider.email, loginFormProvider.password, context);
    }
  }
}
