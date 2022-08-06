import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key? key, this.hasError = false}) : super(key: key);
  final bool hasError;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Background(
          navigatorToHome: true,
          useBackArrow: true,
          useImg: false,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text('Usuarios',
                  style: CustomTextStyle.robotoExtraBold
                      .copyWith(fontSize: 30, color: Colors.white)),
              const SizedBox(height: 40),
              Expanded(
                child: FirebaseAnimatedList(
                  ///Recibe la consulta de los usuarios de la base de datos.
                  query: FirebaseRealtimeService.getUsers(),
                  defaultChild: const CustomProgressIndicator(),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, snapshot, animation, index) {
                    if (!snapshot.exists) {
                      return NotificationsService.showErrorSnackbar(
                          'Ha ocurrido un error a la hora de cargar los datos.');
                    }
                    final user =
                        User.fromMap(jsonDecode(jsonEncode(snapshot.value)));
                    return CustomCard(
                      user: user,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
