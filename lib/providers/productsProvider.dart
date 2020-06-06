import 'package:flutter/material.dart';
import 'package:shop_app/DummyProducts.dart';
import 'package:shop_app/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;
  // bool showFavoritesOnly = false;

  List<Product> get items {
    // if (showFavoritesOnly) {
    //   return [
    //     ..._items.where((element) => element.isFavorite == true).toList()
    //   ];
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return [..._items.where((element) => element.isFavorite == true).toList()];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct(Product value) {
    // _items.add(value);
    notifyListeners();
  }

  // void showFavorites() {
  //   showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   showFavoritesOnly = false;
  //   notifyListeners();
  // }
}
