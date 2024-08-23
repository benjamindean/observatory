import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/shared/ui/observatory_shimmer.dart';

class ProductsList extends ConsumerWidget {
  const ProductsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    return purchases.when(
      data: (state) {
        if (state.purchasedProductIds.isNotEmpty) {
          return Text(
            'Thank you for your support!',
            style: context.themes.text.titleMedium?.copyWith(
              color: context.colors.scheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        if (state.isPending) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 4.0),
            child: ObservatoryShimmer(),
          );
        }

        return Wrap(
          spacing: 12.0,
          children: state.products.map((e) {
            return FilledButton(
              onPressed: () {
                ref.read(asyncPurchaseProvider.notifier).purchase(e);
              },
              child: Text(
                e.price,
                style: context.themes.text.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.scheme.onPrimary,
                ),
              ),
            );
          }).toList(),
        );
      },
      loading: () {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 22.0),
          child: ObservatoryShimmer(),
        );
      },
      error: (error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }
}
