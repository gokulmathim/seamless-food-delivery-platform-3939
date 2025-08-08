import 'cart_item.dart';

class Order {
  final String id;
  String status;
  final List<CartItem> items;
  final DateTime placedAt;
  final String deliveryLocation;
  final String restaurantName;
  
  Order({
    required this.id,
    required this.status,
    required this.items,
    required this.placedAt,
    required this.deliveryLocation,
    required this.restaurantName,
  });
}
