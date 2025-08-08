import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/restaurant_provider.dart';
import '../../models/restaurant.dart';
import 'restaurant_menu_screen.dart';

// PUBLIC_INTERFACE
/// Screen to browse and select restaurants.
class RestaurantListScreen extends StatefulWidget {
  static const routeName = '/restaurants';
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() => _loading = true);
    await Provider.of<RestaurantProvider>(context, listen: false)
        .fetchRestaurants();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final restaurants =
        Provider.of<RestaurantProvider>(context).restaurants;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : restaurants.isEmpty
              ? const Center(child: Text("No restaurants found"))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  itemCount: restaurants.length,
                  itemBuilder: (_, idx) {
                    final rest = restaurants[idx];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RestaurantMenuScreen(restaurant: rest),
                          ),
                        ),
                        child: Card(
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(rest.imageUrl, width: 64, height: 64, fit: BoxFit.cover),
                            ),
                            title: Text(rest.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text(rest.description),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
