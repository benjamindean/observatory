import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  }) = _ITADFilters;

  int get filterCount {
    return toJson().values.where((element) => element != null).length;
  }

  MinMax get cutBounds => FilterBounds.cut;

  MinMax get priceBounds => FilterBounds.price;

  factory ITADFilters.fromJson(Map<String, Object?> json) =>
      _$ITADFiltersFromJson(json);
}
