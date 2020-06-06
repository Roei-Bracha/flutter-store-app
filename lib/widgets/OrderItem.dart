import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  const OrderItem(this.order, {Key key}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expended = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expended ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expended = !_expended;
                });
              },
            ),
          ),
          if (_expended)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              height: min(widget.order.products.length * 20.0 + 30, 180),
              child: ListView.builder(
                itemBuilder: (ctx, i) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.order.products[i].title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('${widget.order.products[i].quantity.toString()}x \$${widget.order.products[i].price.toString()}',style: TextStyle(color:Colors.grey,fontSize: 18),),
                  ],
                ),
                itemCount: widget.order.products.length,
              ),
            )
        ],
      ),
    );
  }
}
