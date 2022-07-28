import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tecni_repuestos/models/models.dart';

///Ésta clase corresponde a la conexión a la base datos Firebase y su respectivo
///traslado de datos a los modelos correspondientes.
///Este servicio fue actualizado el 9-7-2022 para implementar la conexión a Realtime.
class FirebaseFirestoreService {
  //Referencia global de la conexión de la base de datos.
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase.
  static Stream<List<Product>> getHomeProducts() {
    final ref = _db.collection('accesorios');
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  ///Éste método obtiene una lista de objetos de tipo categoria los cuales correspondan
  ///a la categoria de accesorios.
  static Stream<List<Category>> getAccessoriesCategory() {
    final ref = _db
        .collection('categories')
        .where('type', isEqualTo: 'accesorios')
        .orderBy('category_label');
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Category.fromMap(doc.data())).toList());
  }

  ///Éste método obtiene una lista de objetos de tipo categoria los cuales correspondan
  ///a la categoria de repuestos.
  static Stream<List<Category>> getSparesCategory() {
    final ref = _db
        .collection('categories')
        .where('type', isEqualTo: 'repuesto')
        .orderBy('category_label');
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Category.fromMap(doc.data())).toList());
  }

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase
  static Stream<List<Product>> getfilteredProducts(
      String collection, String category) {
    final ref =
        _db.collection(collection).where('category', isEqualTo: category);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del UID
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Stream<List<User>> getUserByUid(String uid) {
    final ref = _db.collection('users').where('id', isEqualTo: uid);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => User.fromMap(doc.data())).toList());
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del correo
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<User?> getUserByEmail(String email) {
    return _db.collection('users').where('email', isEqualTo: email).get().then(
        (snapshot) =>
            0 == snapshot.size ? null : User.fromMap(snapshot.docs[0].data()));
  }

  ///Éste método permite crear un nuevo usuario en la base de datos. Es solo requerido cuando
  ///un usuario es registrado por primera vez.
  static void setUser(User user) {
    _db.collection("users").doc(user.id).set({
      'administrator': user.administrator,
      'birthdate': user.birthdate,
      'disabled': user.disabled,
      'email': user.email,
      'id': user.id,
      'lastname': user.lastname,
      'name': user.name,
      'phone': user.phone,
      'vendor': user.vendor
    });
  }

  ///Éste método permite obtener una lista de un objeto de tipo "Address" del usuario
  ///que se encuentre registrado en la amplicación.
  static Stream<List<Address>> getAddressesByUser(String uid) {
    final ref = _db.collection('userAddresses').where('userId', isEqualTo: uid);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Address.fromMap(doc.data())).toList());
  }

  ///Permite actualizar los datos del usuario identificado por medio del UID, en casos
  ///donde no todos los datos fueron alterados, el modelo del usuario guarda los datos
  ///anteririos y los sobreescrible.
  static void updateUser(User user) {
    _db.collection("users").doc(user.id).update({
      'name': user.name,
      'lastname': user.lastname,
      'phone': user.phone,
      'birthdate': user.birthdate
    });
  }

  ///Permiter actualizar los datos de dirrecion de un usuario. En casos
  ///donde no todos los datos fueron alterados, el modelo del dirrecciones guarda los datos
  ///anteririos y los sobreescrible.
  static void updateAddress(Address address) {
    _db.collection("userAddresses").doc(address.id).update({
      'address': address.address,
      'canton': address.canton,
      'province': address.province
    });
  }

  ///Agregan en la base de datoa de Firebase un nuevo registro de Dirreción de facturación
  ///"userAddress"  para esto se asignan los datos de un modelo previamente establecido.
  ///Para que el valor "id" asignado al objeto se el mismo valor autogenerado de Firebase,
  ///guarda el dato con un id nulo y seguidamente actualiza el documento con el id autogenerado.
  static void setAddress(Address address) {
    _db.collection("userAddresses").add({
      'address': address.address,
      'canton': address.canton,
      'id': '',
      'province': address.province,
      'userId': address.userId
    }).then((value) =>
        _db.collection("userAddresses").doc(value.id).update({'id': value.id}));
  }

  ///Elimina un documento de la base de dato de tipo "userAddresses" "Dirreción de facturación"
  ///identificado por su valor único.
  static void deleteAddress(String docId) {
    _db.collection("userAddresses").doc(docId).delete();
  }
}
