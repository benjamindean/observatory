import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final List<ProductDetails> debugList = [
  ProductDetails(
    id: '1',
    title: 'Test',
    description: 'Desc',
    price: '22',
    rawPrice: 22,
    currencyCode: 'USD',
  ),
  ProductDetails(
    id: '2',
    title: 'Test',
    description: 'Desc',
    price: '233',
    rawPrice: 223,
    currencyCode: 'USD',
  ),
];

class AsyncPurchaseNotifier extends AsyncNotifier<PurchaseState> {
  @override
  Future<PurchaseState> build() async {
    return PurchaseState(
      products: await _fetchPurchases(),
      purchasedProductIds:
          await GetIt.I<SettingsRepository>().getPurchasedProductIds(),
      subscription: ref.read(purchaseStreamProvider),
    );
  }

  Future<void> deliverPurchase(String productId) async {
    setIsPending(true);

    final List<String> purchasedProductIds = ref.read(
      asyncPurchaseProvider.select(
        (state) => state.valueOrNull?.purchasedProductIds ?? [],
      ),
    );
    final List<String> newList = {...purchasedProductIds, productId}.toList();

    await GetIt.I<SettingsRepository>().setPurchasedProductIds(newList);

    state = await AsyncValue.guard(() async {
      return state.requireValue.copyWith(
        isPending: false,
        purchasedProductIds: newList,
      );
    });
  }

  Future<void> setIsPending(bool isPending) async {
    state = await AsyncValue.guard(() async {
      return state.requireValue.copyWith(
        isPending: isPending,
      );
    });
  }

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

  Future<void> reset() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return build();
    });
  }
}

final asyncPurchaseProvider =
    AsyncNotifierProvider<AsyncPurchaseNotifier, PurchaseState>(() {
  return AsyncPurchaseNotifier();
});

class PurchaseStreamNotifier
    extends Notifier<StreamSubscription<List<PurchaseDetails>>> {
  @override
  StreamSubscription<List<PurchaseDetails>> build() {
    return InAppPurchase.instance.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) async {
        for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
          final PurchaseStatus status = purchaseDetails.status;

          if (status == PurchaseStatus.pending) {
            ref.read(asyncPurchaseProvider.notifier).setIsPending(true);
          } else {
            if (status == PurchaseStatus.error) {
              ref.read(asyncPurchaseProvider.notifier).setIsPending(false);
            } else if (status == PurchaseStatus.purchased ||
                status == PurchaseStatus.restored) {
              ref.read(asyncPurchaseProvider.notifier).setIsPending(false);
              ref.read(asyncPurchaseProvider.notifier).deliverPurchase(
                    purchaseDetails.productID,
                  );
            }

            if (purchaseDetails.pendingCompletePurchase) {
              await InAppPurchase.instance.completePurchase(purchaseDetails);

              ref.read(asyncPurchaseProvider.notifier).setIsPending(false);
            }
          }
        }
      },
      onError: (error, stackTrace) {
        Sentry.captureException(
          error,
          stackTrace: stackTrace,
        );
      },
    );
  }
}

final purchaseStreamProvider = NotifierProvider<PurchaseStreamNotifier,
    StreamSubscription<List<PurchaseDetails>>>(() {
  return PurchaseStreamNotifier();
});
