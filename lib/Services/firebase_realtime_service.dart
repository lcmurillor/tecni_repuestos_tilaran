import 'package:firebase_database/firebase_database.dart';
import 'package:tecni_repuestos/models/models.dart';

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
    return _db.ref().child('products').limitToLast(5);
  }

  ///Asigna a un objeto de tipo Product en la base de datos la dirección Url por la cual este
  ///objeto puede optener su imagen.
  static setProducImg({required String productId, required String url}) async {
    _db.ref().child('products/$productId').update({"imageUrl": url});
  }

  ///Permite igualar el valor del id de de un producto en la base de datos con su valor
  ///autogenerado, con el fin de mitigar errores y problemas a la hora de hacr consultas
  ///mediante estosdatos.
  static matchProductId() async {
    DataSnapshot dataSnapshot = await _db.ref().child('products').get();
    Map<String, dynamic> data = jsonDecode(jsonEncode(dataSnapshot.value));
    data.forEach((key, value) {
      if (value['id'] != key) {
        _db.ref().child('products/$key').update({'id': key});
      }
    });
  }

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase
  static Query getFilteredProducts(String description) {
    return _db
        .ref()
        .child('products')
        .orderByChild('category')
        .startAt(description);
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del UID
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<UserModel> getUserByUid({required String uid}) async {
    late UserModel user;
    final Query query =
        _db.ref().child('users').orderByChild('id').equalTo(uid);
    final DataSnapshot dataSnapshot = await query.get();
    final Map<String, dynamic> data =
        jsonDecode(jsonEncode(dataSnapshot.value));
    data.forEach((key, value) {
      user = UserModel.fromMap(value);
    });
    return user;
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del correo
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<UserModel> getUserByEmail({required String email}) async {
    late UserModel user;
    final Query query =
        _db.ref().child('users').orderByChild('email').equalTo(email);
    final DataSnapshot dataSnapshot = await query.get();
    final Map<String, dynamic> data =
        jsonDecode(jsonEncode(dataSnapshot.value));
    data.forEach((key, value) {
      user = UserModel.fromMap(value);
    });
    return user;
  }
}
