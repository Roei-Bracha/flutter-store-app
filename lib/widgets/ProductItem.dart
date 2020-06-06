import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/screens/ProductDetailsScreen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // const ProductItem({this.id, this.imageUrl, this.title, Key key})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: ProductDetailsScreenArguments(id: product.id));
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor),
              onPressed: () {
                product.toggleFavoriteStatus();
              }),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.add_shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item added to cart'),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ),
                );
              }),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
