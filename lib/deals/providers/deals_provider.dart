import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/deals/state/deals_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/api/constans.dart';
import 'package:observatory/shared/models/deal.dart';

class AsyncDealsNotifier
    extends AutoDisposeFamilyAsyncNotifier<DealsState, DealCategory> {
  Future<DealsState> _initDeals() async {
    final List<Deal> results = await fetchDeals();
    final List<Deal> deals = Set<Deal>.from(results).toList();

    return DealsState(
      deals: deals,
      hasReachedMax: deals.isEmpty ||
          arg == DealCategory.steam_top_sellers ||
          arg == DealCategory.steam_featured,
      pageNumber: 1,
    );
  }

  @override
  Future<DealsState> build(DealCategory arg) async {
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

    if (arg == DealCategory.all) {
      return api.fetchDeals(
        limit: DEALS_COUNT,
        offset: offset,
      );
    }

    if (arg == DealCategory.steam_top_sellers) {
      return api.fetchSteamTopSellers();
    }

    if (arg == DealCategory.steam_featured) {
      return api.fetchSteamFeatured();
    }

    return api.fetchDealsCategory(
      limit: DEALS_COUNT,
      offset: offset,
      category: arg,
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

final asyncDealsProvider = AsyncNotifierProvider.autoDispose
    .family<AsyncDealsNotifier, DealsState, DealCategory>(
  (AsyncDealsNotifier.new),
);
