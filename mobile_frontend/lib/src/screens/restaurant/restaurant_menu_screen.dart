import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/restaurant.dart';
import '../../providers/restaurant_provider.dart';
import '../../models/menu_item.dart';
import '../../providers/cart_provider.dart';

// PUBLIC_INTERFACE
/// Screen to display a restaurant's menu and allow add to cart.
class RestaurantMenuScreen extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantMenuScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchMenu();
  }

  Future<void> _fetchMenu() async {
    setState(() => _loading = true);
    await Provider.of<RestaurantProvider>(context, listen: false)
        .fetchMenu(widget.restaurant.id);
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = Provider.of<RestaurantProvider>(context).getMenuForRestaurant(widget.restaurant.id);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurant.name)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : menuItems.isEmpty
              ? const Center(child: Text("No menu items"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: menuItems.length,
                  itemBuilder: (_, idx) {
                    final item = menuItems[idx];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: ListTile(
                        leading: Image.network(item.imageUrl, width: 54, height: 54, fit: BoxFit.cover),
                        title: Text(item.name),
                        subtitle: Text(item.description),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("\$${item.price.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w600)),
                            IconButton(
                              icon: const Icon(Icons.add_shopping_cart),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () => cartProvider.addToCart(item),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
