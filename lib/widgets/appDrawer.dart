import 'package:flutter/material.dart';
import 'package:shop_app/screens/OrdersScreen.dart';
import 'package:shop_app/screens/UserProductScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: Text('data'),automaticallyImplyLeading: false,),
          Divider(),
          ListTile(leading: Icon(Icons.shop),title: Text('Shop'),onTap: () => Navigator.pushReplacementNamed(context, '/'),),
          Divider(),
          ListTile(leading: Icon(Icons.payment),title: Text('Orders'),onTap: () => Navigator.pushNamed(context, OrdersScreen.routeName),),
                    Divider(),
          ListTile(leading: Icon(Icons.edit),title: Text('User items'),onTap: () => Navigator.pushReplacementNamed(context, UserProductScreen.routeName),),
        ],
      ),
    );
  }
}