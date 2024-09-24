import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:oauth2/oauth2.dart';

part 'itad_state.freezed.dart';
part 'itad_state.g.dart';

@freezed
@HiveType(typeId: 11)
class ITADUser with _$ITADUser {
  const factory ITADUser({
    @HiveField(0) String? username,
    @HiveField(1) String? credentials,
  }) = _ITADUser;

  factory ITADUser.fromJson(Map<String, Object?> json) =>
      _$ITADUserFromJson(json);
}

@freezed
class ITADState with _$ITADState {
  const factory ITADState({
    ITADUser? user,
    @Default(false) bool isLoading,
    String? error,
    Client? client,
    String? lastSyncDate,
    AuthorizationCodeGrant? grant,
    Uri? autorizationUrl,
  }) = _ITADState;
}
