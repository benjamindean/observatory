import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
@HiveType(typeId: 5)
class Shop with _$Shop {
  const factory Shop({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
  }) = _Shop;

  factory Shop.fromJson(Map<String, Object?> json) => _$ShopFromJson(json);
}
