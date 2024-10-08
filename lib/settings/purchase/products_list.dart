import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ProductsList extends ConsumerStatefulWidget {
  const ProductsList({super.key});

  @override
  ConsumerState<ProductsList> createState() => ProductsListState();
}

class ProductsListState extends ConsumerState<ProductsList> {
  String? selectedProduct;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    return purchases.when(
      data: (state) {
        if (selectedProduct == null && state.products.isNotEmpty) {
          setState(() {
            selectedProduct = state.products.first.id;
          });
        }

        if (state.purchasedProductIds.isNotEmpty) {
          return Text(
            'Thank you for your support!',
            style: context.themes.text.titleMedium?.copyWith(
              color: context.colors.scheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        return Column(
          children: [
            Column(
              children: state.products.map<Widget>(
                (e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RadioListTile<String>(
                      title: Text(e.price),
                      subtitle: Text(e.title),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: context.colors.scheme.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      value: e.id,
                      groupValue: selectedProduct,
                      onChanged: (String? value) {
                        setState(() {
                          selectedProduct = value;
                        });
                      },
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
                    final ProductDetails product = state.products.firstWhere(
                      (element) => element.id == selectedProduct,
                    );

                    InAppPurchase.instance
                        .buyNonConsumable(
                      purchaseParam: PurchaseParam(
                        productDetails: product,
                      ),
                    )
                        .then(
                      (value) {
                        if (value) {
                          GetIt.I<SettingsRepository>().setPurchasedProductIds(
                            product.id,
                          );
                        }
                      },
                    );
                  },
                  child: state.isPending
                      ? ObservatoryProgressIndicator(
                          color: context.colors.scheme.onSecondary,
                          size: 30,
                        )
                      : Text(
                          'Purchase Now for ${state.products.firstWhere((element) => element.id == selectedProduct).price}',
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
