import 'package:cloud_firestore/cloud_firestore.dart';

///Ésteobjeto corresponde a un usuario de la base de datos con todos sus respectivos
///atributos.
class User {
  bool administrator;
  bool disabled;
  bool vendor;
  int birthdate;
  String email;
  String id;
  String lastname;
  String name;
  String phone;

  ///Método constructor de usarios, requiere de todos los atrubutos para ser construido.
  User(
      {required this.administrator,
      required this.disabled,
      required this.vendor,
      required this.birthdate,
      required this.email,
      required this.id,
      required this.lastname,
      required this.name,
      required this.phone});

  /// Éste método resibe un objeto de la base de datos firebese, extrae la
  /// información a un Map y returna un User con todos sus
  /// atributos cargados.
  factory User.fromFirebase(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    return User(
        administrator: data['administrator'] ?? false,
        disabled: data['disabled'] ?? false,
        vendor: data['vendor'] ?? false,
        birthdate: data['birthdate'] ?? 0,
        email: data['email'] ?? 'undefied',
        id: data['id'] ?? 'undefied',
        lastname: data['lastname'] ?? 'undefied',
        name: data['name'] ?? 'undefied',
        phone: data['phone'] ?? 'undefied');
  }
}
