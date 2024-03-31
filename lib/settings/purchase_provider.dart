import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AsyncPurchaseNotifier extends AsyncNotifier<List<ProductDetails>> {
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
  Future<List<ProductDetails>> build() async {
    ref.onDispose(() {
      subscription?.cancel();
    });

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;

    subscription = purchaseUpdated.listen((purchaseDetailsList) async {
      for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
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
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }, onDone: () {
      subscription?.cancel();
    }, onError: (error) {
      return;
    });

    return _fetchPurchases();
  }

  Future<void> reset() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchPurchases());
  }

  Future<void> purchase(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: product,
    );

    await InAppPurchase.instance.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }
}

final asyncPurchaseProvider =
    AsyncNotifierProvider<AsyncPurchaseNotifier, List<ProductDetails>>(() {
  return AsyncPurchaseNotifier();
});
