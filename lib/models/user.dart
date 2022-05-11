///Éste objeto corresponde a un usuario de la base de datos con todos sus respectivos
///atributos.
class UserModel {
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
  UserModel(
      {this.administrator = false,
      this.disabled = false,
      this.vendor = false,
      required this.birthdate,
      required this.email,
      required this.id,
      required this.lastname,
      required this.name,
      required this.phone});
      

  /// Éste método recibe un objeto de la base de datos firebese, extrae la
  /// información a un Map y retorna un User con todos sus
  /// atributos cargados.
  factory UserModel.fromFirebase(Map<String, dynamic> data) {
    return UserModel(
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
