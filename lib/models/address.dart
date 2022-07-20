import 'models.dart';

export 'dart:convert';

///Éste objeto corresponde a una dirreción física que le pertenece al usuario
///registrado en la aplicación. Cada usuario puede disponer de múltiples direcciones.
class Address {
  ///Método constructor de Address, requiere de todos los atributos para poder ser creada.
  Address(
      {required this.address,
      required this.canton,
      required this.id,
      required this.province,
      required this.userId,
      required this.last});

  String address;
  String canton;
  String id;
  String province;
  String userId;
  bool last;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  /// Éste método recibe un objeto de la base de datos firebese, extrae la
  /// información a un Map y retorna una Address con todos sus
  /// atributos cargados.
  factory Address.fromMap(Map<String, dynamic> data) => Address(
      address: data['address'] ?? 'undefined',
      canton: data['canton'] ?? 'undefined',
      id: data['id'] ?? 'undefined',
      province: data['province'] ?? 'undefined',
      userId: data['userId'] ?? 'undefined',
      last: data['last'] ?? false);

  Map<String, dynamic> toMap() => {
        "address": address,
        "canton": canton,
        "id": id,
        "province": province,
        "userId": userId,
        "last": last,
      };
}
