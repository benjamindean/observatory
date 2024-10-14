import 'dart:async';

import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/purchase/products_list.dart';
import 'package:observatory/settings/purchase/purchase_provider.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class PurchasePage extends ConsumerStatefulWidget {
  const PurchasePage({super.key});

  @override
  PurchasePageState createState() => PurchasePageState();
}

class PurchasePageState extends ConsumerState<PurchasePage> {
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;

  bool isPending = false;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;

    subscription = purchaseUpdated.listen(
      (List<PurchaseDetails> purchaseDetailsList) async {
        for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
          final PurchaseStatus status = purchaseDetails.status;

          if (status == PurchaseStatus.pending) {
            setIsPending(true);
          } else {
            if (status == PurchaseStatus.error) {
              setIsPending(false);
            } else if (status == PurchaseStatus.purchased ||
                status == PurchaseStatus.restored) {
              setIsPending(false);

              unawaited(
                deliverPurchase(
                  purchaseDetails.productID,
                  PurchaseStatus.restored == status,
                ),
              );
            }

            if (purchaseDetails.pendingCompletePurchase) {
              await inAppPurchase.completePurchase(purchaseDetails);

              setIsPending(false);
            }
          }
        }
      },
      onDone: () {
        subscription.cancel();
      },
      onError: (error, stackTrace) {
        Sentry.captureException(
          error,
          stackTrace: stackTrace,
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  Future<void> deliverPurchase(String productId, bool isRestored) async {
    setIsPending(true);

    final List<String> purchasedProductIds = ref.read(
      asyncPurchaseProvider.select(
        (state) => state.valueOrNull?.purchasedProductIds ?? [],
      ),
    );

    if (!isRestored) {
      ObservatorySnackBar.show(
        context,
        icon: Icons.favorite,
        content: const Text('Thank you for your support!'),
      );
    }

    await GetIt.I<SettingsRepository>().setPurchasedProductIds(
      {...purchasedProductIds, productId}.toList(),
    );

    return ref.read(asyncPurchaseProvider.notifier).reset();
  }

  Future<void> setIsPending(bool isPendingValue) async {
    setState(() {
      isPending = isPendingValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<PurchaseState> purchases = ref.watch(
      asyncPurchaseProvider,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              setIsPending(true);

              ObservatorySnackBar.show(
                context,
                icon: Icons.refresh,
                content: const Text('Restoring purchases...'),
              );

              InAppPurchase.instance.restorePurchases().then(
                (value) {
                  setIsPending(false);

                  if (context.mounted) {
                    ObservatorySnackBar.show(
                      context,
                      icon: Icons.check,
                      content: const Text('Purchases restored!'),
                    );
                  }
                },
              );
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
                            isPending: isPending,
                            products: state.products,
                            purchasedProductIds: state.purchasedProductIds,
                            onPurchase: (product) async {
                              inAppPurchase.buyNonConsumable(
                                purchaseParam: PurchaseParam(
                                  productDetails: product,
                                ),
                              );
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
                borderRadius: BorderRadius.circular(12.0),
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
