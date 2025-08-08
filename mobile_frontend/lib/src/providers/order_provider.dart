import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/cart_item.dart';

// PUBLIC_INTERFACE
/// Handles order placement, live order, and history.
class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];
  Order? _currentOrder;

  List<Order> get orders => _orders;
  Order? get currentOrder => _currentOrder;

  // PUBLIC_INTERFACE
  Future<bool> placeOrder(List<CartItem> cartItems) async {
    // TODO: API integration, payment flow.
    final newOrder = Order(
      id: DateTime.now().toIso8601String(),
      status: "Pending",
      items: cartItems,
      placedAt: DateTime.now(),
      deliveryLocation: "123 Main Street",
      restaurantName: cartItems.isNotEmpty ? cartItems.first.menuItem.restaurantId : "",
    );
    _orders.insert(0, newOrder);
    _currentOrder = newOrder;
    notifyListeners();
    return true;
  }

  // PUBLIC_INTERFACE
  Future<void> fetchOrderHistory() async {
    // TODO: API call to get orders
    // Returning local orders for demo
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  void updateOrderStatus(String orderId, String newStatus) {
    final order = _orders.firstWhere((o) => o.id == orderId, orElse: () => _currentOrder!);
    order.status = newStatus;
    if (_currentOrder?.id == orderId) {
      _currentOrder!.status = newStatus;
    }
    notifyListeners();
  }
}
