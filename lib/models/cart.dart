import 'models.dart';

export 'dart:convert';

class Cart {
  Cart({
    required this.description,
    required this.productId,
    required this.quantity,
    required this.total,
    required this.userId,
  });

  String description;
  String productId;
  int quantity;
  double total;
  String userId;

  factory Cart.fromJson(String str) => Cart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        description: json["description"] ?? 'undefined',
        productId: json["productId"] ?? 'undefined',
        quantity: json["quantity"].toInt() ?? 0,
        total: json["total"].toDouble() ?? 0.0,
        userId: json["userId"] ?? 'undefined',
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "productId": productId,
        "quantity": quantity,
        "total": total,
        "userId": userId,
      };
}
