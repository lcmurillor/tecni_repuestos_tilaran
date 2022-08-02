import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key? key, this.hasError = false}) : super(key: key);
  final bool hasError;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      Future.delayed(Duration.zero, () {
        if (hasError) {
          NotificationsService.showErrorSnackbar(
              'Ha ocurrido un error en sus paquetes.');
        }
      });
      // final navegacionModel = Provider.of<NavegacionModel>(context);
      return ChangeNotifierProvider(
        create: (_) => NavegacionModel(),
        child: Scaffold(
            bottomNavigationBar: const _Navegacion(),
            body: Background(
              useBackArrow: true,
              useImg: false,
              child: PageView(
                //   controller: navegacionModel.pageController,
                children: [
                  SingleChildScrollView(
                      //   controller: navegacionModel.pageController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 110),
                          Text('USUARIOS',
                              style: CustomTextStyle.robotoSemiBold.copyWith(
                                  fontSize: size.width * 0.09,
                                  color: Colors.white)),
                          Center(
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 30.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  width: 280,
                                  height: 35,
                                  child: TextField(
                                      onTap: () {},
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: _inputDecoration()))),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, 'shipment'),
                            child: Card(
                              child: Column(
                                children: [
                                  moldeRowInfo(
                                      Icons.person,
                                      'Nombre completo del usuario',
                                      CustomTextStyle.robotoExtraBold),

                                  moldeRowInfo(
                                      Icons.email,
                                      'direccion@correo.com',
                                      CustomTextStyle.robotoMedium),
                                  // ,
                                  moldeRowInfo(Icons.phone, '+50685971841',
                                      CustomTextStyle.robotoMedium),
                                  moldeRowInfo(MdiIcons.accountCog, 'Rol: ',
                                      CustomTextStyle.robotoMedium, 'Usuario')
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.green,
                          )
                        ],
                      ))
                ],
              ),
            )),
      );
    });
  }

  Padding moldeRowInfo(IconData icon, String text, TextStyle style,
      [String text2 = '']) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Icon(
              icon,
              color: Colors.redAccent[700],
              size: 30,
            ),
          ),
          Text(text, style: style),
          Text(
            text2,
            style: CustomTextStyle.robotoMedium
                .copyWith(color: ColorStyle.mainBlue),
          ),
        ],
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navegacionModel = Provider.of<NavegacionModel>(context);

    return BottomNavigationBar(
        currentIndex: _navegacionModel.currentPage,
        onTap: (i) => _navegacionModel.currentPage = i,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.archive), label: "Procesados"),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.archiveAlert), label: "Pendientes")
        ]);
  }
}

void _onFormSubmit(LoginFormProvider loginFormProvider, BuildContext context) {
  // FirebaseFirestoreService.getUserByEmail(loginFormProvider.email).then(
  //     (UserModel? user) => _validateData(user, loginFormProvider, context));
}

void _validateData(
    User? user, LoginFormProvider loginFormProvider, BuildContext context) {
  final isValid = loginFormProvider.validateForm();
  if (null != user && !user.disabled && isValid) {
    FirebaseAuthService.signIn(
        loginFormProvider.email, loginFormProvider.password, context);
  } else {
    NotificationsService.showErrorSnackbar(
        'El usuario indicado no está registrado.');
  }
}

InputDecoration _inputDecoration() {
  return InputDecoration(
      prefixStyle: GoogleFonts.roboto(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      hintText: 'Busca un usuario',
      hintStyle: GoogleFonts.roboto(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      prefixIcon: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SvgPicture.asset(
            'assets/search.svg',
            fit: BoxFit.contain,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent)));
}

//Logica de como se obtiene el numero del buttomnavigationbar
class NavegacionModel with ChangeNotifier {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int valor) {
    _currentPage = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
