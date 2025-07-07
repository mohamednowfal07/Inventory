// providers/cart_provider.dart
import 'package:flutter/material.dart';
import 'package:inventory_project/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, Product> _cartItems = {};

  Map<String, Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems[product.id] = product;
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  double get totalprice {
    return _cartItems.values.fold(0.0, (sum, item) => sum + item.price);
  }

  get itemCount => null;

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
