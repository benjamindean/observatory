import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/shared/ui/observatory_shimmer.dart';

class ProductsList extends ConsumerWidget {
  final List<ProductDetails> products;
  final PurchaseStatus? status;
  final List<String> purchasedProductIds;

  const ProductsList({
    super.key,
    this.status = PurchaseStatus.pending,
    this.products = const [],
    this.purchasedProductIds = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (PurchaseStatus.pending == status) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 22.0),
        child: ObservatoryShimmer(),
      );
    }

    return Wrap(
      spacing: 12.0,
      children: products.map((e) {
        final bool isDisabled = PurchaseStatus.pending == status ||
            purchasedProductIds.contains(e.id);

        return FilledButton(
          onPressed: isDisabled
              ? null
              : () {
                  ref.watch(asyncPurchaseProvider.notifier).purchase(e);
                },
          child: Text(
            e.price,
            style: context.themes.text.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDisabled
                  ? context.colors.disabled
                  : context.colors.scheme.onPrimary,
            ),
          ),
        );
      }).toList(),
    );
  }
}
