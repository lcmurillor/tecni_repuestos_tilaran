import 'package:firebase_database/firebase_database.dart';
import 'package:tecni_repuestos/models/models.dart';
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

  ///Asigna a un objeto de tipo Product en la base de datos la dirección Url por la cual este
  ///objeto puede optener su imagen.
  static setProducImg({required String productId, required String url}) async {
    _db.ref().child('products/$productId').update({"imageUrl": url});
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
  static Query getCategories({required String type}) {
    return _db.ref().child('categories').orderByChild('type').equalTo(type);
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
  static Future<UserModel> getUserByEmail({required String email, user}) async {
    late UserModel user = UserModel(
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
        user = UserModel.fromMap(value);
      });
    } else {
      NotificationsService.showErrorSnackbar('Usuario o contraseña invalida.');
    }
    return user;
  }

  ///Éste método permite crear un nuevo usuario en la base de datos. Es solo requerido cuando
  ///un usuario es registrado por primera vez.
  static void setUser({required UserModel user}) {
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
}
