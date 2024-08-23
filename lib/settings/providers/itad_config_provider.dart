import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/deal/providers/deal_provider.dart';
import 'package:observatory/deal/providers/history_provider.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/settings/state/itad_config_state.dart';

import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/store.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class ITADConfigProvider extends AsyncNotifier<ITADConfigState> {
  final SettingsRepository repository = GetIt.I<SettingsRepository>();
  final API api = GetIt.I<API>();

  Future<ITADConfigState> _fetchITADConfig() async {
    final List<Store> stores = await api.stores();
    final List<int> selectedStores = await repository.getSelectedStores();

    if (selectedStores.isEmpty) {
      await repository.setSelectedStores(stores.map((e) => e.id).toList());
    }

    return ITADConfigState(
      selectedCountry: await repository.getCountry(),
      currency: await repository.getCurrency(),
      stores: stores,
      selectedStores: selectedStores.isEmpty
          ? stores.map((e) => e.id).toList()
          : selectedStores,
    );
  }

  @override
  Future<ITADConfigState> build() async {
    return _fetchITADConfig();
  }

  void resetRelatedProviders() {
    ref.invalidate(dealProvider);
    ref.invalidate(historyProvider);
    ref.invalidate(asyncDealsProvider);
    ref.invalidate(asyncWaitListProvider);
  }

  Future<void> setCountry(String country) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await repository.setCountry(country);

        final List<Store> stores = await api.stores();

        await repository.setSelectedStores(stores.map((e) => e.id).toList());

        resetRelatedProviders();

        return state.requireValue.copyWith(
          selectedCountry: country,
          stores: stores,
          selectedStores: stores.map((e) => e.id).toList(),
        );
      },
    );
  }

  Future<void> setCurrency(String currency) async {
    if (state.requireValue.currency == currency) {
      return;
    }

    state = await AsyncValue.guard(
      () async {
        await repository.setCurrency(currency);

        return state.requireValue.copyWith(
          currency: currency,
        );
      },
    );
  }

  Future<void> setSelectedStores(List<int> ids) async {
    state = await AsyncValue.guard(
      () async {
        final List<int> storeIds = ids.toSet().toList();

        await repository.setSelectedStores(storeIds);

        resetRelatedProviders();

        return state.requireValue.copyWith(
          selectedStores: ids,
        );
      },
    );
  }
}

final itadConfigProvider =
    AsyncNotifierProvider<ITADConfigProvider, ITADConfigState>(() {
  return ITADConfigProvider();
});
