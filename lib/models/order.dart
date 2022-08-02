import 'models.dart';

export 'dart:convert';

class Order {
  Order(
      {required this.address,
      required this.arrivelDate,
      required this.attachment,
      required this.carts,
      required this.date,
      required this.id,
      required this.shippingCode,
      required this.shippingMethod,
      required this.status,
      required this.user});

  Map<String, dynamic> address;
  int arrivelDate;
  String attachment;
  Map<String, Map<String, dynamic>> carts;
  int date;
  String id;
  String shippingCode;
  String shippingMethod;
  int status;
  Map<String, dynamic> user;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
      address: json["address"] ?? {},
      arrivelDate: json["arrivelDate"] ?? 0,
      attachment: json["attachment"] ?? 'undefined',
      carts: json["carts"]['cart'] ?? {},
      date: json["date"] ?? 0,
      id: json["id"] ?? 'undefined',
      shippingCode: json["shippingCode"] ?? 'undefined',
      shippingMethod: json["shippingMethod"] ?? 'undefined',
      status: json["status"] ?? 0,
      user: json["user"] ?? {});

  Map<String, dynamic> toMap() => {
        "address": address,
        "arrivelDate": arrivelDate,
        "attachment": attachment,
        "carts": carts,
        "date": date,
        "id": id,
        "shippingCode": shippingCode,
        "shippingMethod": shippingMethod,
        "status": status,
        "user": user
      };
}
