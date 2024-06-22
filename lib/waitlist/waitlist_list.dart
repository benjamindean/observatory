import 'package:collection/collection.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deal/ui/deal_card.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/search/state/search_state.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
import 'package:observatory/settings/steam_import/steam_import_state.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/ory_full_screen_spinner.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/waitlist/ui/empty_waitlist.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:observatory/waitlist/state/waitlist_state.dart';

class WaitListList extends ConsumerWidget {
  const WaitListList({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchState searchState = ref.watch(filterResultsProvider);
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
    final SteamImportState steamImportState = ref.watch(
      steamImportProvider,
    );

    if (steamImportState.isImporting || steamImportState.isLoading) {
      return const OryFullScreenSpinner();
    }

    return waitlist.when(
      loading: () {
        return const OryFullScreenSpinner();
      },
      error: (error, stackTrace) {
        Logger().e(
          'Failed to fetch waitlist',
          error: error,
          stackTrace: stackTrace,
        );

        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
        );

        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: ErrorMessage(
              message: 'Failed to fetch waitlist',
              helper: TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
                onPressed: () async {
                  return ref
                      .watch(asyncWaitListProvider.notifier)
                      .reset(withLoading: true);
                },
              ),
            ),
          ),
        );
      },
      data: (data) {
        if (data.deals.isEmpty) {
          return const EmptyWaitlist();
        }

        if (searchState.isOpen && searchState.query != null) {
          final List<Deal> foundGames = data.deals
              .where(
                (deal) => deal.title.toLowerCase().contains(
                      searchState.query?.toLowerCase() ?? '',
                    ),
              )
              .toList();

          if (foundGames.isEmpty) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: ErrorMessage(
                  message: 'No games found',
                  icon: Icons.sentiment_dissatisfied_rounded,
                ),
              ),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.all(6.0),
            sliver: SliverList.builder(
              itemBuilder: (context, index) {
                return DealCard(
                  deal: foundGames[index],
                );
              },
              itemCount: foundGames.length,
            ),
          );
        }

        final List<Deal> sortedWaitlist = getSortedWaitlist(
          data.deals,
          sorting,
          sortingDirection,
        );

        return SliverPadding(
          padding: const EdgeInsets.all(6.0),
          sliver: SliverList.builder(
            itemBuilder: (context, index) {
              return DealCard(
                deal: sortedWaitlist[index],
              );
            },
            itemCount: sortedWaitlist.length,
          ),
        );
      },
    );
  }
}
