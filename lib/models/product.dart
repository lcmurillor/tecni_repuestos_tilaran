import 'models.dart';

export 'dart:convert';

///Este objeto disponde de todos los atributos de un "product" de la base de datos.
///permite hacer la construcción de un objeto de tipo "product" en base a una consulta.
class Product {
  ///Método constructor de Product, requiere todos los atributos para poder ser creado el objeto
  ///ningún atributo tiene un valor por defecto.
  Product({
    required this.category,
    required this.code,
    required this.cost,
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.quantity,
    required this.type,
  });

  String category;
  String code;
  double cost;
  String description;
  String id;
  String imageUrl;
  String location;
  double price;
  int quantity;
  String type;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  ///Éste método recibe un objeto de tipo Map de la base de datos que corresponde a la interptretación
  ///de un archivo json el cual es el producto, y lo convierte a un objeto de tipo Product para luego ser
  ///usado.
  factory Product.fromMap(Map<String, dynamic> json) => Product(
        category: json["category"] ?? 'undefined',
        code: json["code"] ?? 'undefined',
        cost: json["cost"].toDouble() ?? 0.0,
        description: json["description"] ?? 'undefined',
        id: json["id"] ?? 'undefined',
        imageUrl: json["imageUrl"] ?? 'undefined',
        location: json["location"] ?? 'undefined',
        price: json["price"].toDouble() ?? 0.0,
        quantity: json["quantity"].toInt() ?? 0,
        type: json["type"] ?? 'undefined',
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "code": code,
        "cost": cost,
        "description": description,
        "id": id,
        "imageUrl": imageUrl,
        "location": location,
        "price": price,
        "quantity": quantity,
        "type": type,
      };
}
