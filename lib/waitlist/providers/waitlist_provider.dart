import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/auth/providers/itad_provider.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/search/state/search_state.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';

class AsyncWaitListNotifier extends AsyncNotifier<List<Deal>> {
  Future<List<Deal>> _fetchWaitList() async {
    return GetIt.I<API>().fetchWaitlist();
  }

  @override
  Future<List<Deal>> build() async {
    return _fetchWaitList();
  }

  Future<void> reset({bool withLoading = false}) async {
    await ref.read(asyncBookmarksProvider.notifier).cleanUp();

    if (withLoading) {
      state = const AsyncValue.loading();
    }

    state = await AsyncValue.guard(() => _fetchWaitList());
  }

  Future<void> addToWaitlist(List<Deal> deals) async {
    state = await AsyncValue.guard(
      () async {
        final List<Deal> newDeals = deals.map(
          (deal) {
            return deal.copyWith(
              added: deal.added == 0
                  ? DateTime.now().millisecondsSinceEpoch
                  : deal.added,
            );
          },
        ).toList();

        await GetIt.I<SettingsRepository>().saveDeals(newDeals);

        return Set<Deal>.of(
          List.of(state.valueOrNull ?? [])..addAll(newDeals),
        ).toList();
      },
    );

    unawaited(
      ref
          .read(itadProvider.notifier)
          .addToWaitlist(deals.map((deal) => deal.id).toList()),
    );
  }

  Future<void> removeFromWaitList(Deal deal) async {
    ref.read(itadProvider.notifier).removeFromWaitlist([deal.id]);

    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().removeDeal(deal);

        return List.of(state.valueOrNull ?? [])
          ..removeWhere(
            (element) => element.id == deal.id,
          );
      },
    );
  }

  Future<void> removeFromWaitListBySource(DealSource source) async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().removeDealsBySource(source);

        return List.of(state.valueOrNull ?? [])
          ..removeWhere(
            (element) => element.source == source,
          );
      },
    );
  }

  Future<void> removeSteamImports() async {
    state = await AsyncValue.guard(
      () async {
        final List<Deal> steamDeals = (state.valueOrNull ?? [])
            .where((game) => game.source == DealSource.steam)
            .toList();
        final List<String> steamDealIds = steamDeals
            .map(
              (deal) => deal.id,
            )
            .toList();

        await GetIt.I<SettingsRepository>().removeDeals(steamDeals);

        return List.of(state.valueOrNull ?? [])
          ..removeWhere(
            (element) => steamDealIds.contains(element.id),
          );
      },
    );
  }

  Future<void> clearWaitlist() async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().removeAllDeals();

        return build();
      },
    );
  }
}

final asyncWaitListProvider =
    AsyncNotifierProvider<AsyncWaitListNotifier, List<Deal>>(() {
  return AsyncWaitListNotifier();
});

class SortedWailistNotifier extends Notifier<List<Deal>> {
  @override
  List<Deal> build() {
    final List<Deal> waitlist =
        ref.watch(asyncWaitListProvider).valueOrNull ?? [];
    final List<String> bookmarkIds = ref.watch(bookmarkIdsProvider);
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

    final bool collapse = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.collapsePinned ?? false,
      ),
    );

    final Map<bool, List<Deal>> groupedList = getSortedWaitlist(
      waitlist,
      sorting,
      sortingDirection,
    ).groupListsBy((deal) => bookmarkIds.contains(deal.id));

    if (collapse) {
      return groupedList[false] ?? [];
    }

    return (groupedList[true] ?? [])..addAll(groupedList[false] ?? []);
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
    final SearchState searchState = ref.watch(waitlistSearchProvider);

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

class WaitlistIdsNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    final List<Deal> filteredWaitlist =
        ref.watch(asyncWaitListProvider).valueOrNull ?? [];

    return filteredWaitlist.map((deal) => deal.id).toList();
  }
}

final waitlistIdsProvider = NotifierProvider<WaitlistIdsNotifier, List<String>>(
  WaitlistIdsNotifier.new,
);
