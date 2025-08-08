import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/order_provider.dart';

// PUBLIC_INTERFACE
/// Shows the status of the current order and a mock live map.
class OrderTrackingScreen extends StatelessWidget {
  static const routeName = "/tracking";
  const OrderTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentOrder = Provider.of<OrderProvider>(context).currentOrder;

    return Scaffold(
      appBar: AppBar(title: const Text('Track Order')),
      body: currentOrder == null
          ? const Center(child: Text("No ongoing order"))
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Order Status: ${currentOrder.status}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(height: 20),
                  Container(
                    height: 220,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFA500).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.map, size: 100, color: Color(0xFFFFA500)),
                  ),
                  const SizedBox(height: 10),
                  Text("Your delivery is on the way!",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            ),
    );
  }
}
