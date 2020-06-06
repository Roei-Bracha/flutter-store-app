import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/productsProvider.dart';

class ProductDetailsScreenArguments {
  final String id;

  ProductDetailsScreenArguments({this.id});
}

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProductDetailsScreenArguments routeArgs =
        ModalRoute.of(context).settings.arguments;
    final Product loadedProduct =
        Provider.of<Products>(context, listen: false).findById(routeArgs.id);
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text(loadedProduct.title)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '\$${loadedProduct.price.toString()}',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
