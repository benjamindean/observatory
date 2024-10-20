import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/deals/state/deals_state.dart';
import 'package:observatory/settings/providers/itad_config_provider.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/api/constans.dart';
import 'package:observatory/shared/models/deal.dart';

class AsyncDealsNotifier extends AsyncNotifier<DealsState> {
  Future<DealsState> _initDeals() async {
    final List<Deal> results = await fetchDeals();
    final List<Deal> deals = Set<Deal>.of(results).toList();

    ref.read(itadConfigProvider.notifier).setCurrency(
          results
                  .firstWhere(
                    (deal) => (deal.prices ?? []).isNotEmpty,
                  )
                  .prices
                  ?.firstOrNull
                  ?.price
                  .currency ??
              'USD',
        );

    return DealsState(
      deals: deals,
      hasReachedMax: deals.isEmpty,
      pageNumber: 1,
    );
  }

  @override
  Future<DealsState> build() async {
    return _initDeals();
  }

  Future<void> fetchMore() async {
    if (state.value == null) {
      return;
    }

    state = await AsyncValue.guard(
      () async {
        final int offset = state.requireValue.pageNumber * DEALS_COUNT;

        final List<Deal> results = await fetchDeals(offset: offset);
        final List<Deal> deals = Set<Deal>.of(
          List.of(state.valueOrNull?.deals ?? [])..addAll(results),
        ).toList();

        return state.requireValue.copyWith(
          deals: deals,
          hasReachedMax: results.isEmpty,
          pageNumber: state.requireValue.pageNumber + 1,
        );
      },
    );
  }

  Future<List<Deal>> fetchDeals({int offset = 0}) async {
    final API api = GetIt.I<API>();

    return api.fetchDeals(
      limit: DEALS_COUNT,
      offset: offset,
    );
  }

  Future<void> reset({bool withLoading = false}) async {
    if (withLoading) {
      state = const AsyncValue.loading();
    }

    state = await AsyncValue.guard(() async {
      return _initDeals();
    });
  }
}

final asyncDealsProvider =
    AsyncNotifierProvider<AsyncDealsNotifier, DealsState>(
  (AsyncDealsNotifier.new),
);
