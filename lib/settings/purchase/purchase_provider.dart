import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/purchase/purchase_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AsyncPurchaseNotifier extends AsyncNotifier<PurchaseState> {
  @override
  Future<PurchaseState> build() async {
    await Purchases.configure(
      PurchasesConfiguration(dotenv.env['REVENUECAT_API_KEY']!),
    );

    return PurchaseState(
      products: await _fetchPurchases(),
      purchasedProductIds:
          await GetIt.I<SettingsRepository>().getPurchasedProductIds(),
    );
  }

  Future<StoreProduct?> purchaseProduct(StoreProduct product) async {
    setIsPending(true);

    try {
      final CustomerInfo customerInfo = await Purchases.purchaseStoreProduct(
        product,
      );

      await deliverPurchases(customerInfo.allPurchasedProductIdentifiers);

      setIsPending(false);

      return product;
    } on PlatformException catch (error, stackTrace) {
      setIsPending(false);

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  Future<void> deliverPurchases(List<String> productIds) async {
    setIsPending(true);

    final List<String> purchasedProductIds = ref.watch(
      asyncPurchaseProvider.select(
        (state) => state.valueOrNull?.purchasedProductIds ?? [],
      ),
    );
    final List<String> newList = {
      ...purchasedProductIds,
      ...productIds,
    }.toList();

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

  Future<List<StoreProduct>> _fetchPurchases() async {
    try {
      final List<StoreProduct> products = await Purchases.getProducts(
        [
          'development_support_tier_1',
          'development_support_tier_2',
          'development_support_tier_3',
        ],
        productCategory: ProductCategory.nonSubscription,
      );

      return products..sort((a, b) => a.price.compareTo(b.price));
    } on PlatformException catch (error, stackTrace) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return [];
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

class PlusFeaturesNotifier extends Notifier<bool> {
  @override
  bool build() {
    if (Platform.isAndroid) {
      return true;
    }

    final List<String> purchasedProductIds = ref.watch(
      asyncPurchaseProvider.select(
        (state) => state.valueOrNull?.purchasedProductIds ?? [],
      ),
    );

    return purchasedProductIds.isNotEmpty;
  }
}

final plusFeaturesProvider = NotifierProvider<PlusFeaturesNotifier, bool>(() {
  return PlusFeaturesNotifier();
});
