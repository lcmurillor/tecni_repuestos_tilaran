///Éste objeto corresponde a las diferentes categorias que existen en la aplicación,
///coresponde dato para las caegorias de artículos como la categoría de repuestos.
class Category {
  String categoryLabel;
  String categoryName;
  String id;
  String type;

  ///Método constructor de Category, requiere de todos los atributos para poder ser creada.
  Category(
      {required this.categoryLabel,
      required this.categoryName,
      required this.id,
      required this.type});

  /// Éste método resibe un objeto de la base de datos firebese, extrae la
  /// información a un Map y returna una Category con todos sus
  /// atributos cargados.
  factory Category.fromFirebase(Map<String, dynamic> data) {
    return Category(
        categoryLabel: data['category_label'] ?? 'undefined',
        categoryName: data['category_name'] ?? 'undefined',
        id: data['id'] ?? 'undefined',
        type: data['type'] ?? 'undefined');
  }
}
