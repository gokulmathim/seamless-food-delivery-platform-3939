import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/menu_item.dart';

// PUBLIC_INTERFACE
/// Handles logic for cart management and order creation.
class CartProvider extends ChangeNotifier {
  Map<String, CartItem> _items = {}; // key: menuItemId

  List<CartItem> get items => _items.values.toList();
  double get totalPrice =>
      _items.values.fold(0, (sum, item) => sum + (item.menuItem.price * item.quantity));

  // PUBLIC_INTERFACE
  void addToCart(MenuItem item) {
    if (_items.containsKey(item.id)) {
      _items[item.id]!.quantity += 1;
    } else {
      _items[item.id] = CartItem(menuItem: item, quantity: 1);
    }
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  void removeFromCart(String menuItemId) {
    if (_items.containsKey(menuItemId)) {
      _items.remove(menuItemId);
      notifyListeners();
    }
  }

  // PUBLIC_INTERFACE
  void updateQuantity(String menuItemId, int quantity) {
    if (_items.containsKey(menuItemId) && quantity > 0) {
      _items[menuItemId]!.quantity = quantity;
      notifyListeners();
    }
  }

  // PUBLIC_INTERFACE
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
