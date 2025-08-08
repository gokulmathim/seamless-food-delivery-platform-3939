import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/menu_item.dart';

// PUBLIC_INTERFACE
/// Handles fetching and state for restaurants and menus.
class RestaurantProvider extends ChangeNotifier {
  List<Restaurant> _restaurants = [];
  Map<String, List<MenuItem>> _menus = {}; // restaurantId -> menu items

  List<Restaurant> get restaurants => _restaurants;
  List<MenuItem> getMenuForRestaurant(String restaurantId) => _menus[restaurantId] ?? [];

  // PUBLIC_INTERFACE
  Future<void> fetchRestaurants() async {
    // TODO: API call to fetch restaurants; using mock data for now.
    _restaurants = [
      Restaurant(
        id: "1",
        name: "Burger Palace",
        description: "Delicious burgers & fries",
        imageUrl: "https://via.placeholder.com/150x120.png?text=Burger+Palace",
      ),
      Restaurant(
        id: "2",
        name: "Sushi Express",
        description: "Fresh sushi everyday",
        imageUrl: "https://via.placeholder.com/150x120.png?text=Sushi+Express",
      ),
    ];
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  Future<void> fetchMenu(String restaurantId) async {
    // TODO: API call for menu; using mock data
    _menus[restaurantId] = [
      MenuItem(
        id: 'm1',
        restaurantId: restaurantId,
        name: 'Cheeseburger',
        description: 'Beef patty, cheese, lettuce, tomato',
        price: 7.99,
        imageUrl: "https://via.placeholder.com/88x88.png?text=Burger",
      ),
      MenuItem(
        id: 'm2',
        restaurantId: restaurantId,
        name: 'Veggie Burger',
        description: 'Veggie patty, lettuce, tomato, pickles',
        price: 6.50,
        imageUrl: "https://via.placeholder.com/88x88.png?text=Veg",
      ),
    ];
    notifyListeners();
  }
}
