import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecni_repuestos/main.dart';
import 'package:tecni_repuestos/shared/preferences.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/screens/demo_admin_screen.dart';
import 'package:tecni_repuestos/screens/demo_customer_screen.dart';
import 'package:tecni_repuestos/widgets/card_product.dart';

Widget app({bool dark = false}) => MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkmode: dark)),
    ChangeNotifierProvider(create: (_) => MyCartInfoProvider()),
    ChangeNotifierProvider(create: (_) => ComeFromProvider()),
  ],
  child: const TecniRepuestoTilaran(),
);
Future<void> tapText(WidgetTester tester, String text) async {
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(
    find.text(text),
    250,
    scrollable: find.byType(Drawer).evaluate().isNotEmpty
        ? find
              .descendant(
                of: find.byType(Drawer),
                matching: find.byType(Scrollable),
              )
              .first
        : find.byType(Scrollable).first,
  );
  await tester.ensureVisible(find.text(text));
  await tester.pumpAndSettle();
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() async {
    DemoDatabase.instance.reset();
    SharedPreferences.setMockInitialValues({});
    await Preferences.init();
  });
  test(
    'Catalog complete; database writes, updates and deletes do nothing',
    () async {
      final db = DemoDatabase.instance;
      final before = jsonEncode(db.read(''));
      final catalog =
          (await LocalDataService.getHomeProducts().get()).value as Map;
      expect(catalog.length, 12);
      for (final row in catalog.values) {
        final product = Product.fromMap(Map<String, dynamic>.from(row));
        expect(product.details, isNotEmpty);
        expect(product.specifications.length, 4);
      }
      await db.ref('products/product-1').update({'quantity': 999});
      await db.ref('users/demo-user').remove();
      await db.ref('addresses/new').set({'address': 'new'});
      db.write('orders/new', {'status': 5});
      await LocalDataService.updateOrderStatus(
        orderId: 'DEMO-EJEMPLO',
        status: 5,
      );
      await LocalDataService.setCart(
        cart: Cart(
          id: '',
          description: 'Example',
          productId: 'product-1',
          quantity: 1,
          price: 10,
          total: 10,
          userId: 'demo-user',
        ),
      );
      expect(jsonEncode(db.read('')), before);
      expect(
        demoAdminOrders().map((o) => o.status).toSet(),
        containsAll([1, 2, 3, 4, 5]),
      );
    },
  );
  testWidgets('Admin and checkout navigation never changes data', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final before = jsonEncode(DemoDatabase.instance.read(''));
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Agregar al carrito').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('Modo demo:'), findsOneWidget);
    expect(await LocalDataService.getCartCount(), 0);
    await tester.tap(find.byTooltip('Abrir menú'));
    await tester.pumpAndSettle();
    await tapText(tester, 'Administrar usuarios');
    await tapText(tester, 'Visitante Demo');
    await tapText(tester, 'Cambiar rol del usuario');
    await tapText(tester, 'Administrador');
    expect(demoAdminUsers().first.administrator, false);
    final nav = tester.state<NavigatorState>(find.byType(Navigator).first);
    nav.pop();
    await tester.pumpAndSettle();
    await tapText(tester, 'Gestionar pedidos');
    await tapText(tester, 'DEMO-EJEMPLO');
    await tapText(tester, 'Preparar envío');
    await tapText(tester, 'Confirmar envío');
    expect(find.textContaining('Modo demo:'), findsOneWidget);
    nav.popUntil((r) => r.isFirst);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Abrir menú'));
    await tester.pumpAndSettle();
    await tapText(tester, 'Administrar productos');
    await tapText(tester, 'Pastillas de freno delanteras');
    expect(find.text('Editar producto'), findsOneWidget);
    await tapText(tester, 'Guardar cambios');
    await tapText(tester, 'Eliminar producto');
    expect(find.textContaining('Modo demo:'), findsOneWidget);
    nav.popUntil((r) => r.isFirst);
    await tester.pumpAndSettle();
    nav.pushNamed('myCart');
    await tester.pumpAndSettle();
    await tapText(tester, 'Ver flujo de pedido');
    await tapText(tester, 'Ver envío de comprobante');
    await tapText(tester, 'Agregar imagen');
    expect(find.textContaining('Modo demo:'), findsOneWidget);
    expect(jsonEncode(DemoDatabase.instance.read('')), before);
    expect(tester.takeException(), isNull);
  });
  for (final dark in [false, true]) {
    for (final size in [const Size(320, 640), const Size(640, 360)]) {
      testWidgets('Read-only screens dark=$dark size=$size enlarged text', (
        tester,
      ) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = 1.3;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await tester.pumpWidget(app(dark: dark));
        await tester.pumpAndSettle();
        final context = tester.element(find.byType(CardProduct).first);
        final product = tester
            .widget<CardProduct>(find.byType(CardProduct).first)
            .product;
        final user = demoAdminUsers().first;
        final order = demoAdminOrders().first;
        final before = jsonEncode(DemoDatabase.instance.read(''));
        for (final page in <Widget>[
          const DemoUsersPage(),
          DemoUserPage(user: user),
          DemoUserRolesPage(user: user),
          const DemoOrdersPage(),
          DemoOrderPage(order: order),
          DemoShippingPage(order: order),
          const DemoProductsPage(),
          DemoProductEditPage(product: product),
          const DemoCartPage(),
          const DemoCheckoutPage(),
          const DemoReceiptPage(),
          const DemoAddressesPage(),
          const DemoAddressForm(isNew: true),
          const DemoProfileForm(),
          const DemoAuthForm(),
          const DemoAuthForm(mode: 'register'),
          const DemoAuthForm(mode: 'change'),
          const DemoCustomerOrdersPage(),
          DemoCustomerShipmentPage(order: order),
        ]) {
          openDemoPage(context, page);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull, reason: '${page.runtimeType}');
          expect(
            tester
                .widgetList<TextField>(find.byType(TextField))
                .every((f) => f.readOnly),
            true,
          );
          await tester.drag(find.byType(ListView).last, const Offset(0, -1400));
          await tester.pumpAndSettle();
          expect(
            tester.takeException(),
            isNull,
            reason: '${page.runtimeType} bottom',
          );
          Navigator.of(context).pop();
          await tester.pumpAndSettle();
        }
        expect(jsonEncode(DemoDatabase.instance.read('')), before);
      });
    }
  }
}
