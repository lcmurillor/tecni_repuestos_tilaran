import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = Provider.of<ComeFromProvider>(context);
    currentPage.setScreen(screen: 'myOrder');
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, 'home');
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            body: Background(
          useBackArrow: true,
          navigatorToHome: true,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text('Mis ordenes',
                  style: CustomTextStyle.robotoExtraBold
                      .copyWith(fontSize: 30, color: Colors.white)),
              const SizedBox(height: 40),
              Expanded(
                child: LocalAnimatedList(
                  ///Resive la consulta de la base de datos.
                  query: LocalDataService.getOrdersByUserId(),
                  defaultChild: const CustomProgressIndicator(),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, snapshot, animation, index) {
                    if (!snapshot.exists) {
                      return NotificationsService.showErrorSnackbar(
                          'Ha ocurrido un error a la hora de cargar los datos.');
                    }
                    final order =
                        Order.fromMap(jsonDecode(jsonEncode(snapshot.value)));
                    return CustomCard(order: order);
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
