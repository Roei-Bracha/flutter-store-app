import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import '../widgets/CartItem.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('your cart'),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toString()}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clear();
                      },
                      child: Text('ORDER NOW'),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (ctx, index) => CartItem(
                  id: cart.items.values.toList()[index].id,
                  price: cart.items.values.toList()[index].price,
                  quantity: cart.items.values.toList()[index].quantity,
                  productId: cart.items.keys.toList()[index],
                  title: cart.items.values.toList()[index].title),
              itemCount: cart.items.values.toList().length,
            ))
          ],
        ));
  }
}
