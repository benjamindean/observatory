import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:observatory/shared/models/review.dart';

part 'info.freezed.dart';
part 'info.g.dart';

@freezed
class Info with _$Info {
  const factory Info({
    required String? id,
    @Default('') String slug,
    @Default('game') String type,
    @Default('') String title,
    @Default([]) List<String> tags,
    @Default([]) List<Review> reviews,
  }) = _Info;

  factory Info.fromJson(Map<String, Object?> json) => _$InfoFromJson(json);
}
