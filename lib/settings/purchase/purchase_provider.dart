import 'dart:async';

import 'package:collection/collection.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/settings/settings_repository.dart';

class AsyncPurchaseNotifier extends AsyncNotifier<PurchaseState> {
  @override
  Future<PurchaseState> build() async {
    final List<String> purchasedProductIds =
        await GetIt.I<SettingsRepository>().getPurchasedProductIds();
    final List<ProductDetails> products = await _fetchPurchases();

    return PurchaseState(
      products: products,
      purchasedProductIds: purchasedProductIds,
    );
  }

  Future<List<ProductDetails>> _fetchPurchases() async {
    final bool available = await InAppPurchase.instance.isAvailable();

    if (!available) {
      return [
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

  void setIsPending(bool isPending) {
    state = AsyncValue.data(
      state.requireValue.copyWith(
        isPending: isPending,
      ),
    );
  }

  Future<void> purchase(ProductDetails product) async {
    try {
      setIsPending(true);

      await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: PurchaseParam(
          productDetails: product,
        ),
      );

      setIsPending(false);
    } catch (error, stackTrace) {
      setIsPending(false);

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

  Future<bool> restore() async {
    try {
      setIsPending(true);

      await InAppPurchase.instance.restorePurchases();

      setIsPending(false);

      return true;
    } catch (error, stackTrace) {
      setIsPending(false);

      Logger().e(
        'Failed to restore purchases',
        error: error,
        stackTrace: stackTrace,
      );

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
      );

      return false;
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
