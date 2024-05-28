import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/price_card.dart';
import 'package:observatory/shared/models/price.dart';

class PriceListView extends ConsumerWidget {
  final List<Price>? prices;

  const PriceListView({
    super.key,
    required this.prices,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Price> allPrices = prices ?? [];

    if (allPrices.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.only(bottom: 16.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              ListTile(
                title: Text(
                  'No prices are available for this product at the selected stores.',
                  style: TextStyle(
                    color: context.colors.disabled,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(6.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return PriceCard(
              price: allPrices[index],
            );
          },
          childCount: allPrices.length,
        ),
      ),
    );
  }
}
