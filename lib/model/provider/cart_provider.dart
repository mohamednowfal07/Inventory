// providers/cart_provider.dart
import 'package:flutter/material.dart';
import 'package:inventory_project/model/cart_model.dart';
import 'package:inventory_project/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get cartItems => _cartItems;

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
          product.id,
          (value) => CartModel(
                id: value.id,
                name: value.name,
                image: value.image,
                price: value.price,
                quantity: value.quantity + 1,
              ));
    } else {
      _cartItems[product.id] = CartModel(
          id: product.id,
          name: product.name,
          image: product.image,
          price: product.price);
    }
    ;
    notifyListeners();
  }

  void removeFromCart(String productId) {
    if (_cartItems.containsKey(productId) &&
        _cartItems[productId]!.quantity > 1) {
      _cartItems.update(
        productId,
        (value) => CartModel(
          id: value.id,
          name: value.name,
          image: value.image,
          price: value.price,
          quantity: value.quantity-1,
        ),
      );
    } else {
      _cartItems.remove(productId);
      
    }
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.values.fold(0.0, (sum, item) => sum + item.price);
  }

  get itemCount => null;

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
