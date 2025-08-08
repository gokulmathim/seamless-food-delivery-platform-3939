import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../models/cart_item.dart';

// PUBLIC_INTERFACE
/// The main cart management and order placement screen.
class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    Future<void> placeOrder() async {
      if (cartProvider.items.isEmpty) return;
      final success = await orderProvider.placeOrder(cartProvider.items);
      if (success) {
        cartProvider.clearCart();
        // Optionally navigate to tracking
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Order placed! Tracking order...")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Order placement failed")));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFFFFA500)),
            onPressed: () => cartProvider.clearCart(),
            tooltip: "Clear Cart",
          ),
        ],
      ),
      body: cartProvider.items.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartProvider.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, idx) {
                CartItem item = cartProvider.items[idx];
                return Card(
                  child: ListTile(
                    leading: Image.network(item.menuItem.imageUrl, width: 44, height: 44, fit: BoxFit.cover),
                    title: Text(item.menuItem.name),
                    subtitle: Text("x${item.quantity}  •  \$${(item.menuItem.price * item.quantity).toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Color(0xFFFFA500)),
                      onPressed: () => cartProvider.removeFromCart(item.menuItem.id),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartProvider.items.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: placeOrder,
                  child: Text("Place Order (\$${cartProvider.totalPrice.toStringAsFixed(2)})"),
                ),
              ),
            ),
    );
  }
}
