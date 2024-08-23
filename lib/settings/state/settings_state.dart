import 'package:observatory/settings/settings_repository.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState({
    required bool showHeaders,
    required bool waitlistNotifications,
    @Default(DealCategory.all) DealCategory dealsTab,
    required WaitlistSorting waitlistSorting,
    required WaitlistSortingDirection waitlistSortingDirection,
    required bool crashlyticsEnabled,
    @Default([]) List<String> purchasedProductIds,
    @Default(false) bool collapsePinned,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, Object?> json) =>
      _$SettingsStateFromJson(json);
}
