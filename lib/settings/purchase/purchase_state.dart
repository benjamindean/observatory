import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_state.freezed.dart';

@freezed
class PurchaseState with _$PurchaseState {
  factory PurchaseState({
    @Default([]) List<ProductDetails> products,
    PurchaseStatus? status,
  }) = _PurchaseState;
}
