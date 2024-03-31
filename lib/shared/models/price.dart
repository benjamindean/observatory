import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:intl/intl.dart';
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
class PriceDetails with _$PriceDetails {
  const PriceDetails._();

  const factory PriceDetails({
    @Default(0) double amount,
    @Default(0) int amountInt,
    @Default('USD') String currency,
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
class Price with _$Price {
  const Price._();

  const factory Price({
    required PriceDetails price,
    required PriceDetails regular,
    @Default(0) double cut,
    required Shop shop,
    @Default([]) List<DRM> drm,
    @Default('') String url,
    String? voucher,
    @Default('') String timestamp,
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
