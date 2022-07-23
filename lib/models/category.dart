import 'models.dart';

export 'dart:convert';

///Éste objeto corresponde a las diferentes categorias que existen en la aplicación,
///los datos corresponden tanto para las diferentes categorías de artículos
///como la categoría de repuestos.
class Category {
  Category({
    required this.description,
    required this.id,
    required this.type,
  });

  String description;
  String id;
  String type;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  /// Éste método recibe un objeto de la base de datos firebese, extrae la
  /// información a un Map y retorna una Category con todos sus
  /// atributos cargados.
  factory Category.fromMap(Map<String, dynamic> json) => Category(
        description: json["description"] ?? 'undefined',
        id: json["id"] ?? 'undefined',
        type: json["type"] ?? 'undefined',
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "id": id,
        "type": type,
      };
}
