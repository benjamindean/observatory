import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lzstring/lzstring.dart';

part 'itad_filters.freezed.dart';
part 'itad_filters.g.dart';

class FilterBounds {
  static const MinMax price = MinMax(min: 0, max: 200);
  static const MinMax cut = MinMax(min: 0, max: 100);
}

@HiveType(typeId: 9)
@freezed
class MinMax with _$MinMax {
  const factory MinMax({
    @HiveField(0) @Default(0) int min,
    @HiveField(1) @Default(100) int max,
  }) = _MinMax;

  factory MinMax.fromJson(Map<String, Object?> json) => _$MinMaxFromJson(json);
}

@HiveType(typeId: 8)
@freezed
class ITADFilters with _$ITADFilters {
  const ITADFilters._();

  @JsonSerializable(explicitToJson: true)
  const factory ITADFilters({
    @HiveField(0) MinMax? price,
    @HiveField(1) MinMax? cut,
    @HiveField(2) bool? bundled,
    @HiveField(3) List<String>? tags,
    @HiveField(4) @Default(false) bool mature,
    @HiveField(5) @Default(true) bool nondeals,
  }) = _ITADFilters;

  factory ITADFilters.fromJson(Map<String, Object?> json) =>
      _$ITADFiltersFromJson(json);

  get filtersString {
    return LZString.compressToBase64Sync(
      json.encode(
        {
          'bundled': bundled,
          'cut': cut,
          'price': price,
          'tags': tags,
        },
      ),
    );
  }
}

@freezed
class ITADFiltersConfig with _$ITADFiltersConfig {
  const ITADFiltersConfig._();

  const factory ITADFiltersConfig({
    required ITADFilters cached,
    required ITADFilters current,
  }) = _ITADFiltersConfig;

  factory ITADFiltersConfig.fromJson(Map<String, Object?> json) =>
      _$ITADFiltersConfigFromJson(json);
}
