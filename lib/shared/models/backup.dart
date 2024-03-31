import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup.freezed.dart';
part 'backup.g.dart';

@freezed
class Backup with _$Backup {
  static String fileName = 'observatory_waitlist_backup.json';

  const Backup._();

  const factory Backup({
    String? folder,
    @Default([]) List<String> waitlist,
    String? date,
  }) = _Backup;

  factory Backup.fromJson(Map<String, Object?> json) => _$BackupFromJson(json);
}
