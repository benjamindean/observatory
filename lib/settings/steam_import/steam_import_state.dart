import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:observatory/shared/models/deal.dart';

part 'steam_import_state.freezed.dart';
part 'steam_import_state.g.dart';

@freezed
@HiveType(typeId: 10)
class SteamUser with _$SteamUser {
  const factory SteamUser({
    @HiveField(0) String? steamid,
    @HiveField(1) String? personaname,
    @HiveField(2) String? profileurl,
    @HiveField(3) String? avatarfull,
  }) = _SteamUser;

  factory SteamUser.fromJson(Map<String, Object?> json) =>
      _$SteamUserFromJson(json);
}

@freezed
class SteamState with _$SteamState {
  const factory SteamState({
    SteamUser? steamUser,
    List<Deal>? deals,
    @Default(false) bool isLoading,
    String? error,
  }) = _SteamState;
}
