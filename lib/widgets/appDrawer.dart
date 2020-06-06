import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: Text('data'),automaticallyImplyLeading: false,),
          Divider(),
          ListTile(leading: Icon(Icons.shop),title: Text('Shop'),onTap: () => Navigator.pushNamed(context, '/'),),
          Divider(),
          ListTile(leading: Icon(Icons.payment),title: Text('Orders'),onTap: () => Navigator.pushNamed(context, '/orders'),),
        ],
      ),
    );
  }
}