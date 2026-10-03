// Original interactive flow preserved in docs/product_edit_information_screen-interactive-legacy.dart.txt.
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'demo_admin_screen.dart';

class ProductEditInformationScreen extends StatelessWidget {
  const ProductEditInformationScreen({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) => DemoProductEditPage(product: product);
}
