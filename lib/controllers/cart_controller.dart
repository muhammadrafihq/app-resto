import 'package:flutter/material.dart';
import '../models/cart_model.dart';


class CartController with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  int get cartItemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(CartItem item) {
    final existingItem = _cartItems.firstWhere(
      (cartItem) => cartItem.id == item.id,
      orElse: () => CartItem(id: -1, title: "", image: "", price: 0),
    );
    
    if (existingItem.id == -1) {
      _cartItems.add(item);
    } else {
      existingItem.quantity++;
    }
    notifyListeners();
  }

  void removeFromCart(int id) {
    _cartItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
