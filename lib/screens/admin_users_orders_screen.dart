import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import '../models/models.dart';
import '../providers/providers.dart';

class AdminUsersOrdersScreens extends StatelessWidget {
  const AdminUsersOrdersScreens({
    Key? key,
    this.user,
  }) : super(key: key);
  final User? user;
  @override
  Widget build(BuildContext context) {
    final currentPage = Provider.of<ComeFromProvider>(context);
    currentPage.setScreen(screen: 'adminOrder');
    final Query query = (user == null)
        ? FirebaseRealtimeService.getOrders()
        : FirebaseRealtimeService.getOrdersByUserIdSelected(user!.id);
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => _NavegacionModel(),
        child: Scaffold(
          body: Background(
            useBackArrow: true,
            child: Column(
              children: [
                const SizedBox(height: 60),
                Text('Administrar ordenes',
                    style: CustomTextStyle.robotoExtraBold
                        .copyWith(fontSize: 30, color: Colors.white)),
                const SizedBox(height: 40),
                Expanded(
                  child: _Pages(
                    query: query,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _Navegation(),
        ),
      ),
    );
  }
}

class _Navegation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
        currentIndex: navegacionModel.currentPage,
        onTap: (i) => navegacionModel.currentPage = i,
        items: [
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.archiveClock), label: 'Pendientes'),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.archiveCheck), label: 'Procesados'),
        ]);
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
    required this.query,
  }) : super(key: key);
  final Query query;
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pagecontroller,
      physics: const BouncingScrollPhysics(),
      children: [
        _ProcessedOrders(
          query: query,
          isProcessed: true,
        ),
        _ProcessedOrders(query: query, isProcessed: false),
      ],
    );
  }
}

class _ProcessedOrders extends StatelessWidget {
  const _ProcessedOrders({
    Key? key,
    required this.query,
    required this.isProcessed,
  }) : super(key: key);
  final bool isProcessed;
  final Query query;

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      ///Recibe la consulta de los usuarios de la base de datos.
      query: query,
      defaultChild: const CustomProgressIndicator(),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, snapshot, animation, index) {
        if (!snapshot.exists) {
          return NotificationsService.showErrorSnackbar(
              'Ha ocurrido un error a la hora de cargar los datos.');
        }

        final order = Order.fromMap(jsonDecode(jsonEncode(snapshot.value)));
        if (isProcessed) {
          if (order.status < 5 && order.status > 0) {
            return CustomCard(
              order: order,
            );
          }
        } else {
          if (order.status == 5) {
            return CustomCard(
              order: order,
            );
          }
        }

        return Container();
      },
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;

    _pageController.animateToPage(value,
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
    notifyListeners();
  }

  PageController get pagecontroller => _pageController;
}
