import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/review_provider.dart';
import '../../models/order.dart';

// PUBLIC_INTERFACE
/// User profile page, order history, and review entry.
class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final reviewProvider = Provider.of<ReviewProvider>(context);

    final userName = authProvider.userName ?? "Guest";
    final orders = orderProvider.orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if(authProvider.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => authProvider.logout(),
              tooltip: "Logout",
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(userName,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text("Order History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const Divider(),
            if (orders.isEmpty)
              const Text("No previous orders."),
            if (orders.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, idx) {
                    final order = orders[idx];
                    return Card(
                      child: ListTile(
                        title: Text(order.restaurantName),
                        subtitle: Text("Status: ${order.status} • ${order.placedAt.toLocal()}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.rate_review),
                          tooltip: "Write Review",
                          onPressed: () async {
                            int? rating;
                            final result = await showDialog<String>(
                              context: context,
                              builder: (ctx) {
                                TextEditingController reviewCtrl = TextEditingController();
                                return AlertDialog(
                                  title: const Text("Write Review"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DropdownButtonFormField<int>(
                                        decoration: const InputDecoration(labelText: "Rating"),
                                        items: List.generate(5, (i) => DropdownMenuItem(
                                          value: i+1,
                                          child: Text('${i+1} Star${i == 0 ? '' : 's'}'),
                                        )),
                                        onChanged: (v) => rating = v,
                                      ),
                                      TextField(
                                        controller: reviewCtrl,
                                        decoration: const InputDecoration(labelText: "Comment"),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (rating != null && reviewCtrl.text.isNotEmpty) {
                                          reviewProvider.addReview(
                                            Review(
                                              restaurantId: order.restaurantName,
                                              userId: authProvider.userId ?? "",
                                              rating: rating!,
                                              comment: reviewCtrl.text,
                                            ),
                                          );
                                          Navigator.of(ctx).pop("done");
                                        }
                                      },
                                      child: const Text("Submit"),
                                    )
                                  ],
                                );
                              },
                            );
                            if (result == "done") {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Review submitted!")));
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
