import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:observatory/deal/ui/price_card.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/shop.dart';

void main() {
  testWidgets('Price Card', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PriceCard(
          price: Price(
            price: PriceDetails(amount: 10, currency: 'USD'),
            regular: PriceDetails(amount: 20, currency: 'USD'),
            cut: 50.0,
            shop: Shop(id: 1, name: 'Steam'),
            drm: [
              DRM(id: 1, name: 'Steam'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Steam'), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);
    expect(find.text('\$10.00'), findsOneWidget);
  });

  testWidgets('Price Card: Without Data', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PriceCard(
          price: Price(
            price: PriceDetails(),
            regular: PriceDetails(),
            shop: Shop(id: 1, name: 'Steam'),
          ),
        ),
      ),
    );

    expect(find.text('0%'), findsOneWidget);
    expect(find.text('FREE'), findsOneWidget);
  });
}
