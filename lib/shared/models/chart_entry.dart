import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_entry.freezed.dart';
part 'chart_entry.g.dart';

@freezed
class ChartEntry with _$ChartEntry {
  const factory ChartEntry({
    required String title,
    required String id,
    required double position,
  }) = _ChartEntry;

  factory ChartEntry.fromJson(Map<String, Object?> json) =>
      _$ChartEntryFromJson(json);
}
