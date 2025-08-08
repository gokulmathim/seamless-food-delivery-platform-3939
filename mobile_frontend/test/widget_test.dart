import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend/src/app.dart';

void main() {
  testWidgets('App shows bottom navigation and Restaurants tab', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SeamlessFoodDeliveryApp()));

    // Check for bottom nav icons and title
    expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);
    expect(find.text('Restaurants'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
