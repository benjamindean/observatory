import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/shared/models/price.dart';

class PriceNew extends ConsumerWidget {
  final List<Price>? prices;

  const PriceNew({
    super.key,
    required this.prices,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Price? price = prices?.firstOrNull;

    if (price == null) {
      return Text(
        'No prices are available.',
        style: TextStyle(color: context.colors.disabled),
      );
    }

    return Row(
      children: [
        Text(
          price.price.formattedPrice,
          style: context.themes.text.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Text(
          ' on ',
        ),
        Flexible(
          child: Text(
            price.shop.name,
            style: context.themes.text.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
