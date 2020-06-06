import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/productsProvider.dart';
import 'package:shop_app/widgets/ProductItem.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;
  ProductsGrid({this.showFav});
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favoriteItems :productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
