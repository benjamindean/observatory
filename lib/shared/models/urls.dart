import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'urls.freezed.dart';
part 'urls.g.dart';

@freezed
class Urls with _$Urls {
  const factory Urls({
    required String? package,
    required String? game,
    required String? dlc,
    required String? buy,
  }) = _Urls;

  factory Urls.fromJson(Map<String, Object?> json) => _$UrlsFromJson(json);
}
