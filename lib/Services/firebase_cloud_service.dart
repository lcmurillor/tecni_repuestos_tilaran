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
  static Stream<List<User>> getUser(String uid) {
    final ref = _db.collection('users').where('id', isEqualTo: uid);
    return ref
        .snapshots()
        .map((list) => list.docs.map((doc) => User.fromFirebase(doc)).toList());
  }

  // void getUsers() async {
  //   CollectionReference colletionReference =
  //       FirebaseFirestore.instance.collection("accesorios");

  //   QuerySnapshot users = await colletionReference.get();
  //   if (users.docs.isNotEmpty) {
  //     for (var doc in users.docs) {
  //       //print(doc.data());
  //     }
  //   }
  // }

//haciendo prueba de agregar
  void addPruebaUsuarios() {
    FirebaseFirestore.instance.collection("users").add({'nombre': 'Pedro'});
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
