import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tecni_repuestos/main.dart';
import 'package:tecni_repuestos/widgets/card_product.dart';
import 'package:tecni_repuestos/widgets/app_bar.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';

void main() {
  setUp(() => DemoDatabase.instance.reset());
  test('Local catalog, search, cart and order round-trip', () async {
    expect((await LocalDataService.getHomeProducts().get()).value.length, 12);
    expect(
      (await LocalDataService.getSearchedProducts(
        description: 'FILTRO',
      ).get()).value.length,
      2,
    );
    expect(
      (await LocalDataService.getSearchedProducts(
        description: 'inexistente',
      ).get()).value,
      isNull,
    );
    expect(
      (await LocalDataService.getFilteredProducts(
        description: 'Frenos',
      ).get()).value.length,
      2,
    );
    expect(await LocalDataService.getCartCount(), 0);
    await LocalDataService.setCart(
      cart: Cart(
        description: 'Filtro',
        id: '',
        productId: 'product-3',
        price: 4500,
        quantity: 2,
        total: 9000,
        userId: 'demo-user',
      ),
    );
    expect(await LocalDataService.getCartTotal(), 9000);
    expect(
      await LocalDataService.validateSetCart(productId: 'product-3'),
      isFalse,
    );
    final orderData =
        (await LocalDataService.getOrdersByUserId().get()).value as Map;
    final order = Order.fromMap(
      Map<String, dynamic>.from(orderData.values.first),
    );
    expect(order.carts.length, 1);
    expect(Order.fromJson(order.toJson()).carts.values.first['total'], 9000);
    await LocalDataService.deleteUserCart();
    expect(await LocalDataService.haveCart(), isFalse);
    DemoDatabase.instance.reset();
    expect(await LocalDataService.getCartCount(), 0);
  });

  testWidgets('Visitor can browse, add to cart and simulate an order', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(isDarkmode: false),
          ),
          ChangeNotifierProvider(create: (_) => MyCartInfoProvider()),
          ChangeNotifierProvider(create: (_) => ComeFromProvider()),
        ],
        child: const TecniRepuestoTilaran(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('PROTOTIPO'), findsOneWidget);
    expect(find.text('Pastillas de freno delanteras'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(
      find.descendant(
        of: find.byType(CardProduct).first,
        matching: find.byIcon(Icons.shopping_cart),
      ),
    );
    await tester.pumpAndSettle();
    expect(await LocalDataService.getCartCount(), 1);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(CustomAppBar),
        matching: find.byIcon(Icons.shopping_cart),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Mi carrito'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Simular pedido'));
    await tester.pumpAndSettle();
    expect(find.text('Pedido de demostración'), findsOneWidget);
    expect(await LocalDataService.getCartCount(), 0);
    await tester.tap(find.text('Ver mis pedidos'));
    await tester.pumpAndSettle();
    expect(find.text('DEMO-2'), findsOneWidget);
    await tester.tap(find.text('DEMO-2'));
    await tester.pumpAndSettle();
    expect(find.text('Detalles del envío'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
