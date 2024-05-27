import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:observatory/shared/models/info.dart';
import 'package:observatory/shared/models/overview.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/shop.dart';

part 'deal.freezed.dart';
part 'deal.g.dart';

@HiveType(typeId: 3)
enum DealSource {
  @HiveField(0)
  itad,
  @HiveField(1)
  steam
}

@freezed
@HiveType(typeId: 1)
class Deal with _$Deal {
  const Deal._();

  const factory Deal({
    @HiveField(0) required String id,
    @HiveField(1) @Default('') String slug,
    @Default('game') String type,
    @HiveField(2) @Default('') String title,
    String? steamId,
    Info? info,
    Overview? overview,
    @Default(false) bool isLoading,
    @HiveField(3) @Default(0) int added,
    @HiveField(4) @Default(DealSource.itad) DealSource source,
    @HiveField(5) List<Price>? prices,
  }) = _Deal;

  factory Deal.fromJson(Map<String, Object?> json) => _$DealFromJson(json);

  Price get bestPrice {
    return prices?.first ??
        const Price(
          price: PriceDetails(amount: 0, amountInt: 0, currency: 'Unknown'),
          regular: PriceDetails(amount: 0, amountInt: 0, currency: 'Unknown'),
          shop: Shop(id: 0, name: 'name'),
          cut: 0.0,
          drm: [],
          url: '',
        );
  }

  String? get headerImageURL {
    return 'https://dbxce1spal1df.cloudfront.net/$id/banner600.jpg';
  }

  Price? get steamPrice {
    return prices?.where((price) => price.shop.name == 'Steam').firstOrNull;
  }

  String get titleParsed {
    return HtmlUnescape().convert(title);
  }
}
