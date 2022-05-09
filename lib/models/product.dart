
///Este objeto disponde de todos los atributos de un "accesorio" o "repuesto" de la
///base de datos, por lo tanto se puede usar este tipo "Product" como modelo.
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

  ///Método constructor de Product, requiere todos los atributos para poder ser creado el objeto
  ///ningún atributo tiene un valor por defecto.
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

  /// Éste método resibe un objeto de la base de datos firebese, ya sea un "accesosrio"
  /// o un "repuesto" extrae la información a un Map y returna un Product con todos sus
  /// atributos cargados.
  factory Product.fromFirebase(Map<String, dynamic> data) {
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
