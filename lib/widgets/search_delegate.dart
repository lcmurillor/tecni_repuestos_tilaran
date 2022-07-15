import 'package:animate_do/animate_do.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/theme/color_style.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';

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
    return FirebaseAnimatedList(
      query: FirebaseRealtimeService.getFilteredProducts(query),
      defaultChild: const CustomProgressIndicator(),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, snapshot, animation, index) {
        if (!snapshot.exists) {
          return NotificationsService.showErrorSnackbar(
              'Ha ocurrido un error a la hora de cargar los datos.');
        }
        final product = Product.fromMap(jsonDecode(jsonEncode(snapshot.value)));
        return ZoomIn(child: _PrductItem(product: product));
      },
    );
  }

  Widget _emptyContainer() {
    return Center(
        child: SvgPicture.asset(
      'assets/logo-full-white.svg',
      fit: BoxFit.contain,
      height: 100,
      color: ColorStyle.mainGrey.withOpacity(0.30),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }
    return FirebaseAnimatedList(
      query: FirebaseRealtimeService.getFilteredProducts(query),
      defaultChild: const CustomProgressIndicator(),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, snapshot, animation, index) {
        if (!snapshot.exists) {
          return NotificationsService.showErrorSnackbar(
              'Ha ocurrido un error a la hora de cargar los datos.');
        }
        final product = Product.fromMap(jsonDecode(jsonEncode(snapshot.value)));
        return ZoomIn(child: _PrductItem(product: product));
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
      leading: product.imageUrl.startsWith('http')
          ? FadeInImage(
              placeholder: const AssetImage('assets/placeholder-image.png'),
              image: NetworkImage(product.imageUrl),
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
