import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/search/state/search_state.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/state/waitlist_state.dart';

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

  Future<void> removeSteamImports() async {
    state = await AsyncValue.guard(
      () async {
        final List<Deal> newList = [...state.requireValue.deals]
          ..removeWhere((element) => element.source == DealSource.steam);

        await settingsRepository.removeDealsFromSteam();

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

class SortedWailistNotifier extends Notifier<List<Deal>> {
  @override
  List<Deal> build() {
    final AsyncValue<WaitListState> waitlist = ref.watch(asyncWaitListProvider);
    final WaitlistSortingDirection sortingDirection = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.waitlistSortingDirection,
          ),
        ) ??
        WaitlistSortingDirection.asc;
    final WaitlistSorting sorting = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.waitlistSorting,
          ),
        ) ??
        WaitlistSorting.date_added;

    return getSortedWaitlist(
      waitlist.valueOrNull?.deals ?? [],
      sorting,
      sortingDirection,
    );
  }

  List<Deal> getSortedWaitlist(
    List<Deal> deals,
    WaitlistSorting sorting,
    WaitlistSortingDirection sortingDirection,
  ) {
    final num detractor =
        sortingDirection == WaitlistSortingDirection.asc ? -1 : double.infinity;

    switch (sorting) {
      case WaitlistSorting.date_added:
        return [...deals]..sort(
            (a, b) {
              if (sortingDirection == WaitlistSortingDirection.desc) {
                return (a.added).compareTo(b.added);
              }

              return (b.added).compareTo(a.added);
            },
          );

      case WaitlistSorting.price:
        return [...deals]..sort(
            (a, b) {
              if (sortingDirection == WaitlistSortingDirection.asc) {
                return (b.prices?.firstOrNull?.price.amount ?? detractor)
                    .compareTo(
                        a.prices?.firstOrNull?.price.amount ?? detractor);
              }

              return (a.prices?.firstOrNull?.price.amount ?? detractor)
                  .compareTo(b.prices?.firstOrNull?.price.amount ?? detractor);
            },
          );
      case WaitlistSorting.price_cut:
        return [...deals]..sort(
            (a, b) {
              if (sortingDirection == WaitlistSortingDirection.desc) {
                return (a.prices?.firstOrNull?.cut ?? detractor)
                    .compareTo(b.prices?.firstOrNull?.cut ?? detractor);
              }

              return (b.prices?.firstOrNull?.cut ?? detractor)
                  .compareTo(a.prices?.firstOrNull?.cut ?? detractor);
            },
          );

      case WaitlistSorting.title:
        return [...deals]..sort(
            (a, b) {
              if (sortingDirection == WaitlistSortingDirection.desc) {
                return (b.title).compareTo(a.title);
              }

              return (a.title).compareTo(b.title);
            },
          );
      case WaitlistSorting.discount_date:
        final List<Deal> bottomDeals = [];
        final List<Deal> discountedDeals = deals.where(
          (deal) {
            if (deal.bestPrice.cut == 0) {
              bottomDeals.add(deal);

              return false;
            }

            return true;
          },
        ).toList();

        return [...discountedDeals]
          ..sort(
            (a, b) {
              if (sortingDirection == WaitlistSortingDirection.desc) {
                return (a.bestPrice.timestampMs ?? 0).compareTo(
                  b.bestPrice.timestampMs ?? 0,
                );
              }

              return (b.bestPrice.timestampMs ?? 0).compareTo(
                a.bestPrice.timestampMs ?? 0,
              );
            },
          )
          ..addAll(bottomDeals);

      default:
        return deals;
    }
  }
}

final sortedWaitlistProvider =
    NotifierProvider<SortedWailistNotifier, List<Deal>>(
  SortedWailistNotifier.new,
);

class FilteredWailistNotifier extends Notifier<List<Deal>> {
  @override
  List<Deal> build() {
    final List<Deal> filteredWaitlist = ref.watch(sortedWaitlistProvider);
    final SearchState searchState = ref.watch(filterResultsProvider);

    if (searchState.isOpen && searchState.query != null) {
      return filteredWaitlist
          .where(
            (deal) => deal.title.toLowerCase().contains(
                  searchState.query?.toLowerCase() ?? '',
                ),
          )
          .toList();
    }

    return filteredWaitlist;
  }
}

final filteredWaitlistProvider =
    NotifierProvider<FilteredWailistNotifier, List<Deal>>(
  FilteredWailistNotifier.new,
);
