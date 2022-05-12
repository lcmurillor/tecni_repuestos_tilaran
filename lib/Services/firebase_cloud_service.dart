// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tecni_repuestos/models/models.dart';

///Ésta clase corresponde a la conexión a la base datos Firebase y su respectivo
///traslado de datos a los modelos correspondientes.
class FirebaseCloudService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase.
  static Stream<List<Product>> getHomeProducts() {
    final ref = _db.collection('accesorios');
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Product.fromFirebase(doc.data())).toList());
  }

  ///Éste método obtiene una lista de objetos de tipo categoria los cuales correspondan
  ///a la categoria de accesorios.
  static Stream<List<Category>> getAccessoriesCategory() {
    final ref = _db
        .collection('categories')
        .where('type', isEqualTo: 'accesorios')
        .orderBy('category_label');
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Category.fromFirebase(doc.data())).toList());
  }

  ///Éste método obtiene una lista de objetos de tipo categoria los cuales correspondan
  ///a la categoria de repuestos.
  static Stream<List<Category>> getSparesCategory() {
    final ref = _db
        .collection('categories')
        .where('type', isEqualTo: 'repuesto')
        .orderBy('category_label');
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Category.fromFirebase(doc.data())).toList());
  }

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase
  static Stream<List<Product>> getfilteredProducts(
      String collection, String category) {
    final ref =
        _db.collection(collection).where('category', isEqualTo: category);
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Product.fromFirebase(doc.data())).toList());
  }

  ///Éste método seleciona un usuario de la base de datos Firebase por medio del UID
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Stream<List<UserModel>> getUserByUid(String uid) {
    final ref = _db.collection('users').where('id', isEqualTo: uid);
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => UserModel.fromFirebase(doc.data())).toList());
  }

  ///Éste método seleciona un usuario de la base de datos Firebase por medio del correo
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<UserModel?> getUserByEmail(String email) {
    return _db.collection('users').where('email', isEqualTo: email).get().then(
        (snapshot) => 0 == snapshot.size
            ? null
            : UserModel.fromFirebase(snapshot.docs[0].data()));
  }

  ///Éste método permite crear un nuevo usuario en la base de datos. Es solo requerido cuando
  ///un usuario es registrado por primera vez.
  static void setUser(UserModel user) {
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
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Address.fromFirebase(doc.data())).toList());
  }

  ///Permite actualizar los datos del usario identificado por medio del UID, en casos
  ///donde no todos los datos fueron alterados, el modelo del usuario guarda los datos
  ///anteririos y los sobreescrible.
  static void updateUser(UserModel user) {
    _db.collection("users").doc(user.id).update({
      'name': user.name,
      'lastname': user.lastname,
      'phone': user.phone,
      'birthdate': user.birthdate
    });
  }
}
