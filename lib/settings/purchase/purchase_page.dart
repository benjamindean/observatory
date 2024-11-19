import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/purchase/products_list.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class PurchasePage extends ConsumerWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    ref.listen(
      asyncPurchaseProvider.select(
        (state) => state.requireValue.purchasedProductIds,
      ),
      (prev, next) {
        if (prev != null && next.length > prev.length) {
          ObservatorySnackBar.show(
            context,
            icon: Icons.favorite,
            content: const Text('Thank you for your support!'),
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              ref.read(asyncPurchaseProvider.notifier).setIsPending(true);

              ObservatorySnackBar.show(
                context,
                icon: Icons.refresh,
                content: const Text('Restoring purchases...'),
              );

              try {
                final CustomerInfo customerInfo =
                    await Purchases.restorePurchases();

                ref.read(asyncPurchaseProvider.notifier).deliverPurchases(
                      customerInfo.allPurchasedProductIdentifiers,
                    );
              } on PlatformException catch (error, stackTrace) {
                Logger().e(
                  'Failed to restore purchases',
                  error: error,
                  stackTrace: stackTrace,
                );

                Sentry.captureException(
                  error,
                  stackTrace: stackTrace,
                );

                ref.read(asyncPurchaseProvider.notifier).setIsPending(false);

                if (context.mounted) {
                  ObservatorySnackBar.show(
                    context,
                    icon: Icons.error,
                    content: const Text('Failed to restore purchases'),
                  );
                }
              }
            },
            child: Text(
              'Restore Purchases',
              style: context.textStyles.labelMedium.copyWith(
                color: context.colors.scheme.primary,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: purchases.when(
          data: (state) {
            if (state.products.isEmpty) {
              return const SizedBox.shrink();
            }

            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Observatory Plus',
                              style: context.textStyles.headlineMedium.copyWith(
                                color: context.colors.scheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'This app is free and ad-free, and I intend to keep it that way for the foreseeable future. If you enjoy the app, please consider supporting it. ',
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Please note that there are currently no additional features or benefits for supporters, but it might change in the near future.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ProductsList(
                            isPending: state.isPending,
                            products: state.products,
                            purchasedProductIds: state.purchasedProductIds,
                            onPurchase: (StoreProduct product) {
                              ref
                                  .read(asyncPurchaseProvider.notifier)
                                  .purchaseProduct(product);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
          error: (error, stackTrace) {
            Logger().e(
              'Failed to load purchases',
              error: error,
              stackTrace: stackTrace,
            );

            Sentry.captureException(
              error,
              stackTrace: stackTrace,
            );

            return const SizedBox.shrink();
          },
          loading: () {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                minHeight: 2,
                color: context.colors.scheme.onSurfaceVariant,
              ),
            );
          },
        ),
      ),
    );
  }
}
