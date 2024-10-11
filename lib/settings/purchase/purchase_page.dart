import 'dart:async';

import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;
  bool isPending = false;
  List<String> purchasedProductIds = [];

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    subscription = purchaseUpdated.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
          final PurchaseStatus status = purchaseDetails.status;

          if (status == PurchaseStatus.pending) {
            setIsPending(true);
          } else {
            if (status == PurchaseStatus.error) {
              setIsPending(false);
            } else if (status == PurchaseStatus.purchased ||
                status == PurchaseStatus.restored) {
              return unawaited(deliverPurchase(purchaseDetails.productID));
            }

            if (purchaseDetails.pendingCompletePurchase) {
              _inAppPurchase.completePurchase(purchaseDetails);
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

  Future<void> deliverPurchase(String productId) async {
    setState(() {
      purchasedProductIds = {...purchasedProductIds, productId}.toList();
    });

    await GetIt.I<SettingsRepository>().setPurchasedProductIds(productId);

    return setIsPending(false);
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
      appBar: AppBar(),
      body: purchases.when(
        data: (state) {
          if (state.products.isEmpty) {
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    'Observatory Plus',
                    style: context.textStyles.headlineMedium.copyWith(
                      color: context.colors.scheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const ListTile(
                  subtitle: Column(
                    children: [
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    16.0,
                    8.0,
                    16.0,
                    8.0,
                  ),
                  child: ProductsList(
                    isPending: isPending,
                    onPurchase: (product) async {
                      _inAppPurchase.buyNonConsumable(
                        purchaseParam: PurchaseParam(
                          productDetails: product,
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextButton.icon(
                      onPressed: () {
                        ObservatorySnackBar.show(
                          context,
                          icon: Icons.refresh,
                          content: const Text('Restoring purchases...'),
                        );

                        InAppPurchase.instance.restorePurchases();
                      },
                      label: Text(
                        'Restore Purchases',
                        style: context.textStyles.labelMedium.copyWith(
                          color: context.colors.scheme.primary,
                        ),
                      ),
                      icon: Icon(
                        FontAwesomeIcons.arrowsRotate,
                        color: context.colors.scheme.primary,
                        size: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
    );
  }
}
