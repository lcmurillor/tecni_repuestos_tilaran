import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  double cost;
  double price;
  double total;
  int quantity;
  String category;
  String description;
  String id;
  String item;
  String location;
  String type;
  String img;

  Product(
      {required this.cost,
      required this.price,
      required this.total,
      required this.quantity,
      required this.category,
      required this.description,
      required this.id,
      required this.item,
      required this.location,
      required this.type,
      required this.img});

  factory Product.fromFirebase(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    return Product(
        id: data['id'] ?? 'undefined',
        cost: double.parse(data['cost'] ?? 0.0),
        price: double.parse(data['price'] ?? 0.0),
        total: double.parse(data['total'] ?? 0.0),
        quantity: int.parse(data['quantity'] ?? 0),
        category: data['category'] ?? 'undefined',
        description: data['description'] ?? 'undefined',
        item: data['item'] ?? 'undefined',
        location: data['location'] ?? 'undefined',
        type: data['type'] ?? 'undefined',
        img: data['img'] ?? 'undefined');
  }

  factory Product.fromMap(Map data) {
    return Product(
        id: data['id'] ?? 'undefined',
        cost: double.parse(data['cost'] ?? 0.0),
        price: double.parse(data['price'] ?? 0.0),
        total: double.parse(data['total'] ?? 0.0),
        quantity: int.parse(data['quantity'] ?? 0),
        category: data['category'] ?? 'undefined',
        description: data['description'] ?? 'undefined',
        item: data['item'] ?? 'undefined',
        location: data['location'] ?? 'undefined',
        type: data['type'] ?? 'undefined',
        img: data['img'] ?? 'undefined');
  }
}
