import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'observatory_theme.freezed.dart';
part 'observatory_theme.g.dart';

@freezed
@HiveType(typeId: 2)
class ObservatoryTheme with _$ObservatoryTheme {
  const factory ObservatoryTheme({
    @HiveField(0) required String mode,
    @HiveField(1) required bool isTrueBlack,
    @HiveField(2) @Default('mandyRed') String? scheme,
  }) = _ObservatoryTheme;

  factory ObservatoryTheme.fromJson(Map<String, Object?> json) =>
      _$ObservatoryThemeFromJson(json);
}
