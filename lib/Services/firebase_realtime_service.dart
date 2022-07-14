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
    return _db.ref().child('products').limitToLast(30);
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del UID
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<UserModel> getUserByUid(String uid) async {
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
  static Future<UserModel> getUserByEmail(String email) async {
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
