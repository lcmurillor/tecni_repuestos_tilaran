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
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Product.fromFirebase(doc)).toList());
  }

  ///Éste método obtiene una lista de objetos de tipo categoria los cuales correspondan
  ///a la categoria de accesorios.
  static Stream<List<Category>> getAccessoriesCategory() {
    final ref = _db
        .collection('categories')
        .where('type', isEqualTo: 'accesorios')
        .orderBy('category_label');
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Category.fromFirebase(doc)).toList());
  }

  ///Éste método obtiene una lista de objetos de tipo categoria los cuales correspondan
  ///a la categoria de repuestos.
  static Stream<List<Category>> getSparesCategory() {
    final ref = _db
        .collection('categories')
        .where('type', isEqualTo: 'repuesto')
        .orderBy('category_label');
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Category.fromFirebase(doc)).toList());
  }

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase
  static Stream<List<Product>> getfilteredProducts(
      String type, String category) {
    final ref = _db.collection(type).where('category', isEqualTo: category);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Product.fromFirebase(doc)).toList());
  }

  ///Éste método seleciona un usuario de la base de datos Firebase por medio del UID
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Stream<List<UserModel>> getUser(String uid) {
    final ref = _db.collection('users').where('id', isEqualTo: uid);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => UserModel.fromFirebase(doc)).toList());
  }

  ///Éste método permite crear un uevo usario en la base de datos, es solo requerido cuando
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

  void updateUsuarios() {
    FirebaseFirestore.instance
        .collection("users")
        .doc('xfOZ5bpOA51XBG6CbO5Q')
        .update({'nombre': 'Francisco'});
  }

  void deletePruebaUsuarios() {
    FirebaseFirestore.instance
        .collection("users")
        .doc('VimDJ1bLgs1VGQfBr8ms') // en el doc se manda el id a eliminar
        .delete();
  }
}
