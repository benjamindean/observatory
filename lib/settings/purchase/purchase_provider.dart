import 'dart:async';

import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';

class AsyncPurchaseNotifier extends AsyncNotifier<PurchaseState> {
  StreamSubscription<List<PurchaseDetails>>? subscription;

  Future<List<ProductDetails>> _fetchPurchases() async {
    final bool available = await InAppPurchase.instance.isAvailable();

    if (!available) {
      return [];
    } else {
      const Set<String> purchaseIds = <String>{
        'development_support_tier_1',
        'development_support_tier_2',
        'development_support_tier_3'
      };
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails(
        purchaseIds,
      );

      return response.productDetails.sortedBy(
        (element) => element.rawPrice.toString(),
      );
    }
  }

  @override
  Future<PurchaseState> build() async {
    ref.onDispose(() {
      subscription?.cancel();
    });

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;

    subscription = purchaseUpdated.listen((purchaseDetailsList) async {
      for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
        state = await AsyncValue.guard(
          () async => state.requireValue.copyWith(
            status: purchaseDetails.status,
          ),
        );

        switch (purchaseDetails.status) {
          case PurchaseStatus.pending:
            break;
          case PurchaseStatus.error:
            break;
          case PurchaseStatus.purchased:
            break;
          case PurchaseStatus.restored:
            break;
          case PurchaseStatus.canceled:
            await InAppPurchase.instance.completePurchase(purchaseDetails);

            break;
        }

        if (purchaseDetails.pendingCompletePurchase) {
          state = await AsyncValue.guard(
            () async => state.requireValue.copyWith(
              isPending: true,
            ),
          );

          await InAppPurchase.instance.completePurchase(purchaseDetails);

          FirebaseAnalytics.instance.logBeginCheckout(
            items: [
              AnalyticsEventItem(
                itemId: purchaseDetails.productID,
              ),
            ],
          );

          state = await AsyncValue.guard(
            () async => state.requireValue.copyWith(
              isPending: false,
            ),
          );
        }
      }
    }, onDone: () {
      subscription?.cancel();
    }, onError: (error) {
      return;
    });

    return PurchaseState(
      products: await _fetchPurchases(),
      status: PurchaseStatus.canceled,
    );
  }

  Future<void> reset() async {
    subscription?.cancel();

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  Future<void> purchase(ProductDetails product) async {
    try {
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: product,
      );

      await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to purchase product',
        error: error,
        stackTrace: stackTrace,
      );

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
      );

      return;
    }
  }
}

final asyncPurchaseProvider =
    AsyncNotifierProvider<AsyncPurchaseNotifier, PurchaseState>(() {
  return AsyncPurchaseNotifier();
});
