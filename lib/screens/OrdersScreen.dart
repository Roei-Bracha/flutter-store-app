import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import '../widgets//OrderItem.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key key}) : super(key: key);

  static final String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('your orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderItem(ordersData.orders[index]);
        },
        itemCount: ordersData.orders.length,
      ),
    );
  }
}
