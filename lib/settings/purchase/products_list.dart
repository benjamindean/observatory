import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ProductsList extends ConsumerStatefulWidget {
  final bool isPending;
  final Function(ProductDetails) onPurchase;
  final List<ProductDetails> products;

  const ProductsList({
    super.key,
    required this.isPending,
    required this.onPurchase,
    required this.products,
  });

  @override
  ConsumerState<ProductsList> createState() => ProductsListState();
}

class ProductsListState extends ConsumerState<ProductsList> {
  ProductDetails selectedProduct = ProductDetails(
    id: '0',
    title: 'Unknown',
    description: 'Unknown',
    price: 0.toString(),
    rawPrice: 0,
    currencyCode: 'USD',
  );

  @override
  void initState() {
    super.initState();

    selectedProduct = widget.products.first;
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    return purchases.when(
      data: (state) {
        return Column(
          children: [
            Column(
              children: widget.products.map<Widget>(
                (e) {
                  final bool didPurchase = state.purchasedProductIds.contains(
                    e.id,
                  );

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RadioListTile<ProductDetails>(
                      title: Text(e.price),
                      subtitle: Text(e.title),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: context.colors.scheme.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      value: e,
                      groupValue: selectedProduct,
                      onChanged: !(widget.isPending && didPurchase)
                          ? (ProductDetails? value) {
                              setState(() {
                                selectedProduct = value!;
                              });
                            }
                          : null,
                    ),
                  );
                },
              ).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      context.colors.scheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    widget.onPurchase(selectedProduct);
                  },
                  child: widget.isPending
                      ? ObservatoryProgressIndicator(
                          color: context.colors.scheme.onSecondary,
                          size: 30,
                        )
                      : Text(
                          'Purchase Now for ${state.products.firstWhere((element) => element == selectedProduct).price}',
                          style: context.textStyles.bodyLarge.copyWith(
                            color: context.colors.scheme.onSecondary,
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () {
        return const Center(
          child: ObservatoryProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        Sentry.captureException(
          error,
          stackTrace: stackTrace,
        );

        return const ErrorMessage(
          message: 'Failed to load purchases',
        );
      },
    );
  }
}
