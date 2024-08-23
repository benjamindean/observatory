import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/shop.dart';

part 'history.freezed.dart';
part 'history.g.dart';

@freezed
class HistoryPrice with _$HistoryPrice {
  const factory HistoryPrice({
    required PriceDetails price,
    required PriceDetails regular,
    @Default(0) double cut,
  }) = _HistoryPrice;

  factory HistoryPrice.fromJson(Map<String, Object?> json) =>
      _$HistoryPriceFromJson(json);
}

@freezed
class History with _$History {
  const factory History({
    required String? timestamp,
    Shop? shop,
    HistoryPrice? deal,
  }) = _History;

  factory History.fromJson(Map<String, Object?> json) =>
      _$HistoryFromJson(json);
}
