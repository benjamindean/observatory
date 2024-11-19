import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';

part 'purchase_state.freezed.dart';

@freezed
class PurchaseState with _$PurchaseState {
  factory PurchaseState({
    @Default([]) List<StoreProduct> products,
    @Default([]) List<String> purchasedProductIds,
    @Default(false) bool isPending,
  }) = _PurchaseState;
}
