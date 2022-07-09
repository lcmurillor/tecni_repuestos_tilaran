///Éste objeto corresponde a una dirreción física que le pertenece al usuario
///registrado en la aplicación. Cada usuario puede disponer de múltiples direcciones.
class Address {
  String address;
  String canton;
  String id;
  String province;
  String userId;

  ///Método constructor de Address, requiere de todos los atributos para poder ser creada.
  Address(
      {required this.address,
      required this.canton,
      required this.id,
      required this.province,
      required this.userId});

  /// Éste método recibe un objeto de la base de datos firebese, extrae la
  /// información a un Map y retorna una Address con todos sus
  /// atributos cargados.
  factory Address.fromFirebase(Map<String, dynamic> data) {
    return Address(
        address: data['address'] ?? 'undefined',
        canton: data['canton'] ?? 'undefined',
        id: data['id'] ?? 'undefined',
        province: data['province'] ?? 'undefined',
        userId: data['userId'] ?? 'undefined');
  }
}
