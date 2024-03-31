import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:observatory/shared/models/price.dart';

part 'overview.freezed.dart';
part 'overview.g.dart';

@freezed
class Overview with _$Overview {
  const factory Overview({
    @Default([]) List<OverviewPrices>? prices,
    @Default([]) List<Bundle>? bundles,
  }) = _Overview;

  factory Overview.fromJson(Map<String, Object?> json) =>
      _$OverviewFromJson(json);
}

@freezed
class OverviewPrices with _$OverviewPrices {
  const factory OverviewPrices({
    required String id,
    Price? current,
    Price? lowest,
  }) = _OverviewPrices;

  factory OverviewPrices.fromJson(Map<String, Object?> json) =>
      _$OverviewPricesFromJson(json);
}

@freezed
class Bundle with _$Bundle {
  const Bundle._();

  const factory Bundle({
    required int id,
    required String title,
    required String url,
    required String details,
    required BundlePage page,
    String? expiry,
  }) = _Bundle;

  get isExpired {
    if (expiry == null) {
      return true;
    }

    return DateTime.parse(expiry!).difference(DateTime.now()).inDays < 0;
  }

  factory Bundle.fromJson(Map<String, Object?> json) => _$BundleFromJson(json);
}

@freezed
class BundlePage with _$BundlePage {
  const factory BundlePage({
    required int id,
    required String name,
  }) = _BundlePage;

  factory BundlePage.fromJson(Map<String, Object?> json) =>
      _$BundlePageFromJson(json);
}
