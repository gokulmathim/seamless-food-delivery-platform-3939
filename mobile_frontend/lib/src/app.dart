import 'package:flutter/material.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/restaurant/restaurant_list_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/order/order_tracking_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'theme.dart';

class SeamlessFoodDeliveryApp extends StatefulWidget {
  const SeamlessFoodDeliveryApp({Key? key}) : super(key: key);

  @override
  State<SeamlessFoodDeliveryApp> createState() => _SeamlessFoodDeliveryAppState();
}

class _SeamlessFoodDeliveryAppState extends State<SeamlessFoodDeliveryApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    RestaurantListScreen(),
    CartScreen(),
    OrderTrackingScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seamless Food Delivery',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (ctx, _, __) {
        // This is where you would check authentication and redirect if necessary.
        return _widgetOptions[_selectedIndex];
      }),
      routes: {
        AuthScreen.routeName: (_) => const AuthScreen(),
        RestaurantListScreen.routeName: (_) => const RestaurantListScreen(),
        CartScreen.routeName: (_) => const CartScreen(),
        OrderTrackingScreen.routeName: (_) => const OrderTrackingScreen(),
        ProfileScreen.routeName: (_) => const ProfileScreen(),
      },
      // Bottom navigation as the main structure, minimalistic & modern.
      builder: (context, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppTheme.navBarBackground,
            selectedItemColor: AppTheme.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu),
                label: 'Restaurants',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.delivery_dining),
                label: 'Track',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
