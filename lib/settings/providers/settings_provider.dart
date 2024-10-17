import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/settings/state/settings_state.dart';

import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/store.dart';
import 'package:observatory/tasks/check_waitlist.dart';

class AsyncSettingsNotifier extends AsyncNotifier<SettingsState> {
  final SettingsRepository repository = GetIt.I<SettingsRepository>();
  final API api = GetIt.I<API>();

  Future<SettingsState> _fetchSettings() async {
    final List<Store> stores = await api.stores();
    final List<int> selectedStores = await repository.getSelectedStores();

    if (selectedStores.isEmpty) {
      await repository.setSelectedStores(stores.map((e) => e.id).toList());
    }

    return SettingsState(
      showHeaders: await repository.getShowHeaders(),
      dealsTab: await repository.getDealsTab(),
      waitlistNotifications: await repository.getWaitlistNotifications(),
      waitlistSorting: await repository.getWaitlistSorting(),
      waitlistSortingDirection: await repository.getWaitlistSortingDirection(),
      collapsePinned: await repository.getCollapsePinned(),
    );
  }

  @override
  Future<SettingsState> build() async {
    return _fetchSettings();
  }

  Future<void> setShowHeaders(bool showHeaders) async {
    state = await AsyncValue.guard(
      () async {
        await repository.setShowHeaders(showHeaders);

        return state.requireValue.copyWith(
          showHeaders: showHeaders,
        );
      },
    );
  }

  Future<void> setDealsTab(DealCategory category) async {
    state = await AsyncValue.guard(
      () async {
        await repository.setDealsTab(category);

        return state.requireValue.copyWith(
          dealsTab: category,
        );
      },
    );
  }

  Future<void> setWaitlistNotifications(bool isEnabled) async {
    state = await AsyncValue.guard(
      () async {
        await repository.setWaitlistNotifications(isEnabled);

        if (isEnabled) {
          await enableCheckWaitlistTask();
        } else {
          await disableCheckWaitlistTask();
        }

        return state.requireValue.copyWith(
          waitlistNotifications: isEnabled,
        );
      },
    );
  }

  Future<void> setWaitlistSorting(WaitlistSorting sorting) async {
    state = await AsyncValue.guard(
      () async {
        await repository.setWaitlistSorting(sorting);

        return state.requireValue.copyWith(
          waitlistSorting: sorting,
        );
      },
    );
  }

  Future<void> setWaitlistSortingDirection(
    WaitlistSortingDirection direction,
  ) async {
    state = await AsyncValue.guard(
      () async {
        await repository.setWaitlistSortingDirection(direction);

        return state.requireValue.copyWith(
          waitlistSortingDirection: direction,
        );
      },
    );
  }

  Future<void> setCollapsePinned(bool collapse) async {
    state = await AsyncValue.guard(
      () async {
        await repository.setCollapsePinned(collapse);

        return state.requireValue.copyWith(
          collapsePinned: collapse,
        );
      },
    );
  }
}

final asyncSettingsProvider =
    AsyncNotifierProvider<AsyncSettingsNotifier, SettingsState>(() {
  return AsyncSettingsNotifier();
});
