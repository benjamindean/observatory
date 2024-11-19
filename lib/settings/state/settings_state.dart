import 'package:observatory/settings/settings_repository.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState({
    required bool showHeaders,
    required bool waitlistNotifications,
    required WaitlistSorting waitlistSorting,
    required WaitlistSortingDirection waitlistSortingDirection,
    @Default([]) List<String> purchasedProductIds,
    @Default(false) bool collapsePinned,
    @Default(true) bool muteGamesInLibrary,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, Object?> json) =>
      _$SettingsStateFromJson(json);
}
