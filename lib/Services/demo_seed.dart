import 'demo_product_details.dart';

/// Fictional data shipped with the build. No remote images or personal records.
Map<String, dynamic> demoSeed() {
  final user = <String, dynamic>{
    'id': 'demo-user',
    'name': 'Visitante',
    'lastname': 'Demo',
    'email': 'demo@example.com',
    'phone': '00000000',
    'identification': '000000000',
    'identificationType': 0,
    'birthdate': 946684800000,
    'administrator': false,
    'vendor': false,
    'disabled': false,
    'profileImg': 'assets/placeholder-user.png',
  };
  final address = <String, dynamic>{
    'id': 'demo-address',
    'userId': 'demo-user',
    'province': 'Guanacaste',
    'canton': 'Tilarán',
    'address': 'Dirección ficticia para demostración',
    'last': true,
  };
  const items = [
    ['Pastillas de freno delanteras', 'Frenos', 'spare', 12500, 12],
    ['Disco de freno ventilado', 'Frenos', 'spare', 28500, 6],
    ['Filtro de aceite universal', 'Filtros', 'spare', 4500, 24],
    ['Filtro de aire para motor', 'Filtros', 'spare', 8500, 15],
    ['Bujía de encendido', 'Motor', 'spare', 3500, 30],
    ['Correa de distribución', 'Motor', 'spare', 18500, 7],
    ['Amortiguador delantero', 'Suspensión', 'spare', 42000, 4],
    ['Rótula de suspensión', 'Suspensión', 'spare', 16500, 0],
    ['Casco integral negro', 'Protección', 'accesorie', 45000, 8],
    ['Guantes para motociclista', 'Protección', 'accesorie', 14500, 10],
    ['Soporte para celular', 'Equipamiento', 'accesorie', 9500, 18],
    ['Juego de luces LED', 'Iluminación', 'accesorie', 22000, 5],
  ];
  final products = <String, dynamic>{};
  final categories = <String, dynamic>{};
  for (var i = 0; i < items.length; i++) {
    final row = items[i];
    final id = 'product-${i + 1}';
    categories['${row[1]}'] = {
      'id': '${row[1]}',
      'description': row[1],
      'type': row[2],
    };
    products[id] = {
      'id': id,
      'description': row[0],
      'category': row[1],
      'type': row[2],
      'code': 'TR-${(i + 1).toString().padLeft(3, '0')}',
      'price': row[3],
      'cost': row[3],
      'quantity': row[4],
      'location': 'Estante de demostración',
      'imageUrl': 'assets/products/product-${i + 1}.jpg',
      ...demoProductDetails[i],
    };
  }
  return {
    'products': products,
    'categories': categories,
    'users': {'demo-user': user},
    'addresses': {'demo-address': address},
    'carts': <String, dynamic>{},
    'orders': <String, dynamic>{
      'DEMO-EJEMPLO': {
        'id': 'DEMO-EJEMPLO',
        'user': Map<String, dynamic>.from(user),
        'address': Map<String, dynamic>.from(address),
        'date': DateTime(2026, 9, 20).millisecondsSinceEpoch,
        'arrivelDate': DateTime(2026, 9, 23).millisecondsSinceEpoch,
        'attachment': '',
        'shippingCode': 'DEMO-ENVIO',
        'shippingMethod': 'Envío simulado',
        'status': 3,
        'carts': <String, dynamic>{
          'sample': {
            'id': 'sample',
            'productId': 'product-3',
            'description': 'Filtro de aceite universal',
            'price': 4500.0,
            'quantity': 2,
            'total': 9000.0,
            'userId': 'demo-user',
          },
        },
      },
    },
  };
}
