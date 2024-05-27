import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:observatory/shared/models/shop.dart';

part 'price.freezed.dart';
part 'price.g.dart';

@freezed
class DRM with _$DRM {
  const factory DRM({
    @Default(0) int id,
    @Default('Unknown') String name,
  }) = _DRM;

  factory DRM.fromJson(Map<String, Object?> json) => _$DRMFromJson(json);
}

@freezed
@HiveType(typeId: 6)
class PriceDetails with _$PriceDetails {
  const PriceDetails._();

  const factory PriceDetails({
    @HiveField(0) @Default(0) double amount,
    @HiveField(1) @Default(0) int amountInt,
    @HiveField(2) @Default('USD') String currency,
  }) = _PriceDetails;

  factory PriceDetails.fromJson(Map<String, Object?> json) =>
      _$PriceDetailsFromJson(json);

  String get formattedPrice {
    if (amount == 0) {
      return 'FREE';
    }

    final NumberFormat formatCurrency = NumberFormat.simpleCurrency(
      name: currency,
    );

    return formatCurrency.format(amount);
  }
}

@freezed
@HiveType(typeId: 4)
class Price with _$Price {
  const Price._();

  const factory Price({
    @HiveField(0) required PriceDetails price,
    @HiveField(1) required PriceDetails regular,
    @HiveField(2) @Default(0) double cut,
    @HiveField(3) required Shop shop,
    @Default([]) List<DRM> drm,
    @Default('') String url,
    @HiveField(4) String? voucher,
    @HiveField(5) @Default('') String timestamp,
    @HiveField(6) num? timestampMs,
  }) = _Price;

  String get formattedDRM {
    if (shop.name == 'Steam') {
      return 'Steam';
    }

    if (drm.isEmpty) {
      return 'Unknown';
    }

    return drm.map((e) => e.name.capitalize()).join(', ');
  }

  factory Price.fromJson(Map<String, Object?> json) => _$PriceFromJson(json);
}
