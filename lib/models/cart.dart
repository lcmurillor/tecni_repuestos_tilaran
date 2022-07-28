import 'models.dart';

export 'dart:convert';

class Cart {
  Cart({
    required this.description,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.total,
    required this.userId,
  });

  String description;
  String id;
  String productId;
  double price;
  int quantity;
  double total;
  String userId;

  factory Cart.fromJson(String str) => Cart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        description: json["description"] ?? 'undefined',
        id: json["id"] ?? 'undefined',
        productId: json["productId"] ?? 'undefined',
        price: json["price"].toDouble() ?? 0.0,
        quantity: json["quantity"].toInt() ?? 0,
        total: json["total"].toDouble() ?? 0.0,
        userId: json["userId"] ?? 'undefined',
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "id": id,
        "productId": productId,
        "price": price,
        "quantity": quantity,
        "total": total,
        "userId": userId,
      };
}
