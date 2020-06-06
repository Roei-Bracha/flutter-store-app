import 'package:flutter/material.dart';
import 'package:shop_app/DummyProducts.dart';
import 'package:shop_app/models/product.dart';
import 'package:uuid/uuid.dart';

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
    final newProduct = Product(
        id: Uuid().v4(),
        title: value.title,
        description: value.description,
        imageUrl: value.imageUrl,
        price: value.price);
    _items.add(newProduct);
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void editProduct(Product product) {
    final productIndex =
        _items.indexWhere((element) => element.id == product.id);
    if (productIndex >= 0) {
      _items[productIndex] = product;
      notifyListeners();
    }
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
