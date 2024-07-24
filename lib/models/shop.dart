import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';

class Shop extends ChangeNotifier {
  List<Product> _userCart = [];
  List<Product> getUserCart() {
    return _userCart;
  }

  void addProductToCart(Product item) {
    _userCart.add(item);
    notifyListeners();
  }

  void removeItemFromCart(Product item) {
    _userCart.remove(item);
    notifyListeners();
  }
}
