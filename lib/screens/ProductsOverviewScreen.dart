import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/screens/CartScreen.dart';
import 'package:shop_app/widgets/ProductsGrid.dart';
import 'package:shop_app/widgets/appDrawer.dart';
import 'package:shop_app/widgets/badge.dart';

enum FilterOptinos { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('my shop'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptinos value) {
              setState(() {
                if (value == FilterOptinos.all) {
                  _showFavoritesOnly = false;
                } else if (value == FilterOptinos.favorites) {
                  _showFavoritesOnly = true;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('only favorites'),
                value: FilterOptinos.favorites,
              ),
              PopupMenuItem(
                child: Text('show all'),
                value: FilterOptinos.all,
              ),
            ],
          ),
          Consumer<Cart>(
              builder: (context, cart, child) => Badge(
                    child: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.pushNamed(context, CartScreen.routeName);
                      },
                    ),
                    value: cart.itemCount.toString(),
                  ))
        ],
      ),
      body: ProductsGrid(showFav: _showFavoritesOnly),
    );
  }
}
