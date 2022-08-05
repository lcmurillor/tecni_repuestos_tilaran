import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/services/services.dart';

///Ésta clase corresponde a la conexión a la base datos Firebase reialtime.
///En esta se ecuentra una instancia de conexión global y las respetivas consultas.
class FirebaseRealtimeService {
  //Referencia global de la conexión de la base de datos.
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

  ///Permite seleccionar artículos de la base de datos de la categoría "products"
  ///para mostrar en la pantalla principal, estos produtos además se pueden filtrar
  ///según el rubro deseado por el usuario.
  static Query getHomeProducts(
      {bool filterByType = false,
      String? type,
      bool fillerByValue = false,
      double fistValue = 0,
      double lastValue = 1000000}) {
    if (filterByType) {
      return _db.ref().child('products').orderByChild('type').equalTo(type);
    } else if (fillerByValue) {
      return _db
          .ref()
          .child('products')
          .orderByChild('price')
          .startAt(fistValue)
          .endAt(lastValue);
    }
    return _db.ref().child('products').limitToLast(100);
  }

  //   static Future<List<Product>> getHomeProducts() async {
  //   List<Product> products = [];
  //   final Query query = _db.ref().child('products').limitToLast(100);
  //   final DataSnapshot dataSnapshot = await query.get();
  //   final Map<String, dynamic> data =
  //       jsonDecode(jsonEncode(dataSnapshot.value));
  //   data.forEach((key, value) {
  //     products.add(Product.fromMap(value));
  //   });
  //   return products;
  // }

  ///Asigna a un objeto de tipo Product en la base de datos la dirección Url por la cual este
  ///objeto puede optener su imagen.
  static setProducImg({required String productId, required String url}) async {
    _db.ref().child('products/$productId').update({"imageUrl": url});
  }

  ///Asigna a un objeto de tipo User en la base de datos la dirección Url por la cual este
  ///objeto puede optener su imagen.
  static setUserImg({required String userId, required String url}) async {
    _db.ref().child('users/$userId').update({"profileImg": url});
  }

  ///Permite igualar el valor del id de de un producto en la base de datos con su valor
  ///autogenerado, con el fin de mitigar errores y problemas a la hora de hacr consultas
  ///mediante estosdatos.
  static matchId() async {
    DataSnapshot dataSnapshot = await _db.ref().child('products').get();
    Map<String, dynamic> data = jsonDecode(jsonEncode(dataSnapshot.value));
    data.forEach((key, value) {
      if (value['type'] == 'repuesto') {
        _db.ref().child('products/$key').update({'type': 'spare'});
      }
    });
  }

  ///Éste método obtiene una lista de objetos de tipo categoria los cuales correspondan.
  static Future<List<Category>> getCategories({required String type}) async {
    List<Category> categories = [];
    final Query query =
        _db.ref().child('categories').orderByChild('type').equalTo(type);
    final DataSnapshot dataSnapshot = await query.get();
    final Map<String, dynamic> data =
        jsonDecode(jsonEncode(dataSnapshot.value));
    data.forEach((key, value) {
      categories.add(Category.fromMap(value));
    });
    return categories;
  }

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase. Es utilizado para la barra de busqueda.
  static Query getSearchedProducts({required String description}) {
    return _db
        .ref()
        .child('products')
        .orderByChild('category')
        .startAt(description)
        .limitToFirst(40);
  }

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase. Es utilizado para mostrar los procutos filtrados pot tipo y tategoría.
  static Query getFilteredProducts({required String description}) {
    return _db
        .ref()
        .child('products')
        .orderByChild('category')
        .equalTo(description);

    // final DataSnapshot dataSnapshot = await query.get();
    // final Map<String, dynamic> data =
    //     jsonDecode(jsonEncode(dataSnapshot.value));
    // data.forEach((key, value) {
    //   products.add(CardItem(product: Product.fromMap(value)));
    // });
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del UID
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<User> getUserByUid({required String uid}) async {
    late User user;
    final Query query =
        _db.ref().child('users').orderByChild('id').equalTo(uid);
    final DataSnapshot dataSnapshot = await query.get();
    final Map<String, dynamic> data =
        jsonDecode(jsonEncode(dataSnapshot.value));
    data.forEach((key, value) {
      user = User.fromMap(value);
    });
    return user;
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del UID
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Query getUserQueryByUid({required String uid}) {
    return _db.ref().child('users').orderByChild('id').equalTo(uid);
  }

  static Query getUsers() {
    return _db.ref().child('users').orderByChild('disabled').equalTo(false);
  }

  static Query getOrders() {
    return _db.ref().child('orders');
  }

  static Query getUser({required User user, required String id}) {
    return _db.ref().child('users');
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del correo
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<User> getUserByEmail({required String email}) async {
    late User user = User(
        birthdate: 0,
        email: '',
        id: '',
        identification: '',
        identificationType: 0,
        lastname: '',
        name: '',
        phone: '',
        profileImg: '');
    final Query query =
        _db.ref().child('users').orderByChild('email').equalTo(email);
    final DataSnapshot dataSnapshot = await query.get();
    if (dataSnapshot.value != null) {
      final Map<String, dynamic> data =
          jsonDecode(jsonEncode(dataSnapshot.value));
      data.forEach((key, value) {
        user = User.fromMap(value);
      });
    } else {
      NotificationsService.showErrorSnackbar('Usuario o contraseña invalida.');
    }
    return user;
  }

  ///Éste método permite crear un nuevo usuario en la base de datos. Es solo requerido cuando
  ///un usuario es registrado por primera vez.
  static void setUser({required User user}) {
    _db.ref().child('users/${user.id}').set({
      'administrator': user.administrator,
      'birthdate': user.birthdate,
      'disabled': user.disabled,
      'email': user.email,
      'id': user.id,
      'identification': user.identification,
      'identificationType': user.identificationType,
      'lastname': user.lastname,
      'name': user.name,
      'phone': user.phone,
      'profileImg': user.profileImg,
      'vendor': user.vendor
    });
  }

  ///Permite actualizar los datos del usuario identificado por medio del UID, en casos
  ///donde no todos los datos fueron alterados, el modelo del usuario guarda los datos
  ///anteririos y los sobreescrible.
  static void updateUser({required User user}) {
    _db.ref().child('users/${user.id}').update({
      'birthdate': user.birthdate,
      'identification': user.identification,
      'identificationType': user.identificationType,
      'lastname': user.lastname,
      'name': user.name,
      'phone': user.phone,
    });
  }

  static Future<void> updateUserRol({required User user}) async {
    _db.ref().child('users/${user.id}').update({
      'administrator': user.administrator,
      'vendor': user.vendor,
    });
  }

  static void updateProduct({required Product product}) {
    _db.ref().child('products/${product.id}').update({
      'description': product.description,
      'code': product.code,
      'cost': product.cost,
      'location': product.location,
      'type': product.type,
      'price': product.price,
      'quantity': product.quantity
    });
  }

  static void deleteProduct({required String productId}) {
    _db.ref('products/$productId').remove();
  }

  static void deleteUser({required String id}) {
    _db.ref('users/$id').update({'disabled': true});
  }

  ///Éste método permite obtener una lista de un objeto de tipo "Address" del usuario
  ///que se encuentre registrado en la aplicación.
  static Future<List<Address>> getAddressesByUser({required String uid}) async {
    List<Address> addresses = [];
    final Query query =
        _db.ref().child('addresses').orderByChild('userId').equalTo(uid);
    final DataSnapshot dataSnapshot = await query.get();
    if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
      final Map<String, dynamic> data =
          jsonDecode(jsonEncode(dataSnapshot.value));
      data.forEach((key, value) {
        addresses.add(Address.fromMap(value));
      });
    }
    return addresses;
  }

  ///Éste método permite obtener un objeto de tipo "Address" del usuario
  ///que se encuentre registrado en la aplicación.
  static Future<Address>? getAddressByUser({required String uid}) async {
    Address address = Address(
        address: '', canton: '', id: '', province: '', userId: '', last: false);

    bool noLast = true;
    final Query query =
        _db.ref().child('addresses').orderByChild('userId').equalTo(uid);
    final DataSnapshot dataSnapshot = await query.get();
    if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
      final Map<String, dynamic> data =
          jsonDecode(jsonEncode(dataSnapshot.value));
      data.forEach((key, value) {
        if (value['last']) {
          noLast = false;
          address = Address.fromMap(value);
        }
      });
      if (noLast) {
        data.forEach((key, value) {
          address = Address.fromMap(value);
        });
      }
    }

    return address;
  }

  ///Permiter actualizar los datos de dirrecion de un usuario. En casos
  ///donde no todos los datos fueron alterados, el modelo del dirrecciones guarda los datos
  ///anteririos y los sobreescrible.
  static Future<void> updateAddress(
      {required Address address, required BuildContext context}) async {
    Future(() => _setAddressFalse()).then((value) {
      _db.ref("addresses/${address.id}").update({
        'address': address.address,
        'canton': address.canton,
        'id': address.id,
        'province': address.province,
        'last': true,
      });
    }).then((value) => Navigator.popAndPushNamed(context, 'addresses'));
  }

  ///Agregan en la base de datoa de Firebase un nuevo registro de Dirreción de facturación
  ///"address". Para esto se asignan los datos de un modelo previamente establecido.
  static Future<void> setAddress(
      {required Address address, required BuildContext context}) async {
    _setAddressFalse().then((value) {
      final String id = _db.ref('addresses').push().key!;
      _db.ref('addresses/$id').set({
        'address': address.address,
        'canton': address.canton,
        'id': id,
        'province': address.province,
        'userId': address.userId,
        'last': true,
      });
    }).then((value) => Navigator.popAndPushNamed(context, 'addresses'));
  }

  static Future<void> updateLastAddress(
      {required BuildContext context, required Address address}) async {
    _setAddressFalse().then(
      (value) {
        _db.ref("addresses/${address.id}").update({
          'last': true,
        });
      },
    ).then((value) => Navigator.popAndPushNamed(context, 'myCart'));
  }

  ///Define el estado en "false" de todas las direcciones de un usuario para actualizar y definir
  ///la última agregada o editada a "true"
  static Future<void> _setAddressFalse() async {
    DataSnapshot dataSnapshot = await _db
        .ref()
        .child('addresses')
        .orderByChild('userId')
        .equalTo(FirebaseAuthService.auth.currentUser!.uid)
        .get();
    if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(dataSnapshot.value));
      data.forEach((key, value) {
        _db.ref().child('addresses/$key').update({'last': false});
      });
    }
  }

  ///Elimina un registro de la base de dato de tipo "addresses" "Dirreción de facturación"
  ///identificado por su valor único.
  static Future<void> deleteAddress({required String key}) async {
    _db.ref('addresses/$key').remove();
  }

  ///Realiza la consulta con la base de datos para obtener una lista de productos agregados
  ///al carrito de un usuario en específico.
  static Query getCart() {
    return _db
        .ref()
        .child('carts')
        .orderByChild('userId')
        .equalTo(FirebaseAuthService.auth.currentUser!.uid);
  }

  ///Éste método relaiza una cosulta para optener todos los productos cuargados en el carrito de un usuario
  ///seguidamente hace un recorrido de la lista para sumar los valores y retornar el total de compra de la
  ///lista completa, tomando en cuenta el total que cada elemento (precio base x cantidad =  total).
  static Future<double> getCartTotal() async {
    double total = 0;
    if (FirebaseAuthService.auth.currentUser != null) {
      final Query query = getCart();
      final DataSnapshot dataSnapshot = await query.get();
      if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
        final Map<String, dynamic> data =
            jsonDecode(jsonEncode(dataSnapshot.value));
        data.forEach((key, value) {
          Cart cart = Cart.fromMap(value);
          total += cart.total;
        });
      }
    }
    return total;
  }

  static Future<bool> haveCart() async {
    bool have = false;
    final Query query = getCart();
    final DataSnapshot dataSnapshot = await query.get();
    if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
      have = true;
    }
    return have;
  }

  ///Cuanta la cantidad de procutos en el cart del usuario para mostrarlo la notificación.
  static Future<int> getCartCount() async {
    int count = 0;
    if (FirebaseAuthService.auth.currentUser != null) {
      final Query query = getCart();
      final DataSnapshot dataSnapshot = await query.get();
      if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
        final Map<String, dynamic> data =
            jsonDecode(jsonEncode(dataSnapshot.value));
        data.forEach((key, value) {
          count++;
        });
      }
    }
    return count;
  }

  ///Éste método retorna la cantidad en existencia de un producto en específico, esto para hacer validaciones
  ///y definir limites a la hora de adquirir existencias.
  static Future<int> getProductQuantity({required String key}) async {
    int quantity = 0;
    final Query query = _db.ref().child('products/$key');
    final DataSnapshot dataSnapshot = await query.get();
    if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
      final Map<String, dynamic> data =
          jsonDecode(jsonEncode(dataSnapshot.value));
      quantity = data['quantity'];
    }
    return quantity;
  }

  ///Agrega un nuevo objeto de tipo cart en la base de datos asociado al usuario con la cuenta activa.
  static Future<void> setCart({required Cart cart, context}) async {
    final String id = _db.ref('carts').push().key!;
    _db.ref('carts/$id').set({
      'description': cart.description,
      'id': id,
      'productId': cart.productId,
      'price': cart.price,
      'quantity': cart.quantity,
      'total': cart.total,
      'userId': FirebaseAuthService.auth.currentUser!.uid,
    });
  }

  ///Éste método permite actualizar la cantidad y el total de un cart en especifico en la base de datos
  ///esto para guardar de manere más facil los pedidos del usuario y estimar los costos de estos.
  static Future<void> updateCartValue({required Cart cart}) async {
    _db.ref("carts/${cart.id}").update({
      'quantity': cart.quantity,
      'total': cart.total,
    });
  }

  ///Valida si se puede agregar un producto al carrito o no en base a si el usuario está registrado y
  ///además si existen existencia de ese producto en particular. Si no hay existencias, no se puede guardar en el carrito.
  static Future<bool> validateSetCart({required String productId}) async {
    bool isValid = true;
    if (FirebaseAuthService.auth.currentUser != null) {
      final Query query = getCart();
      final DataSnapshot dataSnapshot = await query.get();
      if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
        final Map<String, dynamic> data =
            jsonDecode(jsonEncode(dataSnapshot.value));
        data.forEach((key, value) {
          if (value['productId'] == productId) {
            isValid = false;
          }
        });
      }
    }
    return isValid;
  }

  /// Elimina todos los objetos del carrito de un usuario específico.
  static Future<void> deleteUserCart() async {
    final Query query = getCart();
    final DataSnapshot dataSnapshot = await query.get();
    if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
      final Map<String, dynamic> data =
          jsonDecode(jsonEncode(dataSnapshot.value));
      data.forEach((key, value) {
        _db.ref('carts/$key').remove();
      });
    }
  }

  ///Elimina de la base de datos el carrito selecionado.
  static Future<void> deleteCart({required String key}) async {
    _db.ref('carts/$key').remove();
  }

  ///Obtiene una lista de ordenes de la base de datos cuando estas pertenecen al usuario registrado.
  static Query getOrdersByUserId() {
    return _db
        .ref()
        .child('orders')
        .orderByChild('user/id')
        .equalTo(FirebaseAuthService.auth.currentUser!.uid);
  }

  static Query getOrdersByUserIdSelected(
    String userId,
  ) {
    return _db.ref().child('orders').orderByChild('user/id').equalTo(userId);
  }

  ///Agrega un nuevo objeto de tipo order en la base de datos con los datos del usuario y
  ///todos los productos que se encuentran en el carrito de compra.
  static Future<String> setOrder({required BuildContext context}) async {
    final Address address =
        Provider.of<MyCartInfoProvider>(context, listen: false).getAddress();
    final User user =
        await getUserByUid(uid: FirebaseAuthService.auth.currentUser!.uid);
    final Map<String, Map<String, dynamic>> carts =
        await _getCats(uid: user.id);
    final String id = _db.ref('orders').push().key!;

    final Order order = Order(
        address: address.toMap(),
        arrivelDate:
            DateTime.now().add(const Duration(days: 3)).millisecondsSinceEpoch,
        attachment: '',
        carts: carts,
        date: DateTime.now().millisecondsSinceEpoch,
        id: id,
        shippingCode: 'Pendiente de definir',
        shippingMethod: 'Correos de Costa Rica',
        status: 0,
        user: user.toMap());

    _db.ref('orders/$id').set(order.toMap());
    return id;
  }

  ///Realiza un conversión de datos para exportar una lista de cats a la base de datos en la orden.
  static Future<Map<String, Map<String, dynamic>>> _getCats(
      {required String uid}) async {
    Map<String, Map<String, dynamic>> carts = {};
    final Query query = getCart();
    final DataSnapshot dataSnapshot = await query.get();
    final Map<String, dynamic> data =
        jsonDecode(jsonEncode(dataSnapshot.value));
    data.forEach((key, value) {
      carts.addEntries([MapEntry(key, value)]);
    });

    return carts;
  }

  ///Esta función evista que exitan multiples ordenes sin procesar por usuario, identifica
  ///si existe una orden sin procesar ya registrada por el usuario, si es así, la borra y la remplaza.
  static Future<bool> validateExistingOrders() async {
    bool exists = false;
    final Query query = getOrdersByUserId();

    final DataSnapshot dataSnapshot = await query.get();
    if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
      final Map<String, dynamic> data =
          jsonDecode(jsonEncode(dataSnapshot.value));
      data.forEach((key, value) {
        if (value['status'] == 0) {
          exists = true;
        }
      });
    }

    return exists;
  }

  ///Realiza un recorrido y borra todas las ordenes sin procesar de un usuario espeífico.
  ///esto con el fin de eliminar datos basura. solo devería existir una orden sin procesar por usuario.
  static Future<void> deleteOrderStatus0() async {
    final Query query = getOrdersByUserId();
    final DataSnapshot dataSnapshot = await query.get();
    if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
      final Map<String, dynamic> data =
          jsonDecode(jsonEncode(dataSnapshot.value));
      data.forEach((key, value) {
        if (value['status'] == 0) {
          _db.ref().child('orders/$key').remove();
        }
      });
    }
  }

  static setOrderImg({required String orderId, required String url}) async {
    _db.ref().child('orders/$orderId').update({"attachment": url});
  }

  static Future<void> updateOrderStatus(
      {required String orderId, required int status}) async {
    _db.ref().child('orders/$orderId').update({"status": status});
  }
}
