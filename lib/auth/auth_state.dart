import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oauth2/oauth2.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    Credentials? credentials,
  }) = _AuthenticationState;

  factory AuthenticationState.fromJson(Map<String, Object?> json) =>
      _$AuthenticationStateFromJson(json);
}
