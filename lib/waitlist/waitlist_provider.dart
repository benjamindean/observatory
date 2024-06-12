import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/waitlist_state.dart';

class AsyncWaitListNotifier extends AsyncNotifier<WaitListState> {
  final SettingsRepository settingsRepository = GetIt.I<SettingsRepository>();
  final API api = GetIt.I<API>();

  Future<WaitListState> _fetchWaitList() async {
    final List<Deal> waitlist = await api.fetchWaitlist();

    return WaitListState(
      deals: waitlist,
      ids: waitlist.map((e) => e.id).toList(),
    );
  }

  @override
  Future<WaitListState> build() async {
    return _fetchWaitList();
  }

  Future<void> reset({bool withLoading = false}) async {
    if (withLoading) {
      state = const AsyncValue.loading();
    }

    state = await AsyncValue.guard(() => _fetchWaitList());
  }

  Future<void> addToWaitlist(Deal deal) async {
    state = await AsyncValue.guard(
      () async {
        final List<Deal> newList = {
          ...state.requireValue.deals,
          deal.copyWith(
            added: DateTime.now().millisecondsSinceEpoch,
          ),
        }.toList();

        await settingsRepository.saveDeal(deal);

        return state.requireValue.copyWith(
          ids: newList.map((e) => e.id).toList(),
          deals: newList,
        );
      },
    );
  }

  Future<void> removeFromWaitList(Deal deal) async {
    state = await AsyncValue.guard(
      () async {
        final List<Deal> newList = [...state.requireValue.deals]..removeWhere(
            (element) => element.id == deal.id,
          );

        await settingsRepository.removeDeal(deal);

        return state.requireValue.copyWith(
          ids: newList.map((e) => e.id).toList(),
          deals: newList,
        );
      },
    );
  }

  Future<void> clearWaitlist() async {
    state = await AsyncValue.guard(
      () async {
        await settingsRepository.removeAllDeals();

        return build();
      },
    );
  }
}

final asyncWaitListProvider =
    AsyncNotifierProvider<AsyncWaitListNotifier, WaitListState>(() {
  return AsyncWaitListNotifier();
});
