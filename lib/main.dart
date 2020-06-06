import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/productsProvider.dart';
import 'package:shop_app/screens/CartScreen.dart';
import 'package:shop_app/screens/EditProductScreen.dart';
import 'package:shop_app/screens/OrdersScreen.dart';
import 'package:shop_app/screens/ProductDetailsScreen.dart';
import 'package:shop_app/screens/ProductsOverviewScreen.dart';
import 'package:shop_app/screens/UserProductScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => Products()),
      ChangeNotifierProvider(create: (context) => Cart()),
      ChangeNotifierProvider(create: (context) => Orders()),
    ],
     child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (ctx) => ProductOverviewScreen(),
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName : (c)=> CartScreen(),
          OrdersScreen.routeName : (c)=>OrdersScreen(),
          UserProductScreen.routeName: (c)=>UserProductScreen(),
          EditProductScreen.routeName:(c)=>EditProductScreen(),
        },
      ), 
    );
  }
}
