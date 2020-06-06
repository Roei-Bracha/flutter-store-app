import 'package:flutter/material.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:uuid/uuid.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.amount, this.dateTime, this.id, this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: DateTime.now(),
            products: cartProducts,
            id: Uuid().v4()));
    notifyListeners();
  }
}
