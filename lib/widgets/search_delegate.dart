import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';

bool hasData = false;

class ProductsSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar un producto";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseCloudService.getfilteredProducts(
          (hasData) ? 'accesorios' : 'repuesto', query),
      builder: (_, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) {
          hasData = !hasData;
          return _emptyContainer();
        }

        final data = snapshot.data!;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (_, index) => _PrductItem(
            product: data[index],
          ),
        );
      },
    );
  }

  Widget _emptyContainer() {
    return const Center(
      child: Icon(
        Icons.build_circle,
        color: Colors.black38,
        size: 100,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }
    return StreamBuilder(
      stream: FirebaseCloudService.getfilteredProducts(
          (hasData) ? 'accesorios' : 'repuesto', query),
      builder: (_, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) {
          hasData = !hasData;
          return _emptyContainer();
        }

        final data = snapshot.data!;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (_, index) => _PrductItem(
            product: data[index],
          ),
        );
      },
    );
  }
}

class _PrductItem extends StatelessWidget {
  const _PrductItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.img.startsWith('http')
          ? FadeInImage(
              placeholder: const AssetImage('assets/placeholder-image.png'),
              image: NetworkImage(product.img),
              placeholderFit: BoxFit.cover,
              fit: BoxFit.cover,
              width: 50,
              height: 80)
          : const Image(
              image: AssetImage('assets/placeholder-image.png'),
              fit: BoxFit.cover,
              width: 50,
              height: 80),
      title: Text(product.description),
      subtitle: Text('Disponibles: ${product.quantity}'),
      onTap: () {
        //Navigator.pushNamed(context, 'details', arguments: product);
      },
    );
  }
}
