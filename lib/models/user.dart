import 'models.dart';

export 'dart:convert';

///Éste objeto corresponde a un usuario de la base de datos con todos sus respectivos
///atributos.
class UserModel {
  ///Método constructor de usarios, requiere de todos los atrubutos para ser construido.
  UserModel(
      {this.administrator = false,
      required this.birthdate,
      this.disabled = false,
      required this.email,
      required this.id,
      required this.identification,
      required this.identificationType,
      required this.lastname,
      required this.name,
      required this.phone,
      required this.profileImg,
      this.vendor = false});

  bool administrator;
  int birthdate;
  bool disabled;
  String email;
  String id;
  String identification;
  int identificationType;
  String lastname;
  String name;
  String phone;
  String profileImg;
  bool vendor;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  ///Éste método recibe un objeto de tipo Map de la base de datos que corresponde a la interptretación
  ///de un archivo json el cual es el usuario, y lo convierte a un objeto de tipo UserModel para luego ser
  ///usado.
  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        administrator: json["administrator"] ?? false,
        birthdate: json["birthdate"] ?? 0,
        disabled: json["disabled"] ?? false,
        email: json["email"] ?? 'undefined',
        id: json["id"] ?? 'undefined',
        identification: json["identification"] ?? 'undefined',
        identificationType: json["identificationType"] ?? 0,
        lastname: json["lastname"] ?? 'undefined',
        name: json["name"] ?? 'undefined',
        phone: json["phone"] ?? 'undefined',
        profileImg: json["profileImg"] ?? 'undefined',
        vendor: json["vendor"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "administrator": administrator,
        "birthdate": birthdate,
        "disabled": disabled,
        "email": email,
        "id": id,
        "identification": identification,
        "identificationType": identificationType,
        "lastname": lastname,
        "name": name,
        "phone": phone,
        "profileImg": profileImg,
        "vendor": vendor,
      };
}
