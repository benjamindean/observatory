import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deal/providers/deal_card_size_provider.dart';
import 'package:observatory/deal/ui/deal_card.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/deals/state/deals_state.dart';
import 'package:observatory/router.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/ui/ory_full_screen_spinner.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/load_more.dart';

class DealsList extends ConsumerWidget {
  const DealsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DealCategory dealsCategory = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.dealsTab ?? DealCategory.all,
      ),
    );
    final DealCardType cardType = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.dealCardType ?? DealCardType.compact,
      ),
    );

    final AsyncValue<DealsState> deals = ref.watch(
      asyncDealsProvider(dealsCategory),
    );
    final AsyncDealsNotifier dealsNotifier = ref.watch(
      asyncDealsProvider(dealsCategory).notifier,
    );

    final double cardHeight = ref
        .watch(dealCardSizeProvider.notifier)
        .getHeight(MediaQuery.of(context).size.width);

    return deals.when(
      loading: () {
        return const OryFullScreenSpinner();
      },
      error: (error, stackTrace) {
        Logger().e(
          'Failed to fetch deals',
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
              icon: FontAwesomeIcons.solidFaceDizzy,
              message:
                  'Failed to fetch deals. The service might be down at the moment. Please try again later.',
              helper: TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
                onPressed: () {
                  dealsNotifier.reset(withLoading: true);
                },
              ),
            ),
          ),
        );
      },
      data: (data) {
        if (data.deals.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: ErrorMessage(
                message:
                    'No deals matching the current filters found in the selected category.',
                icon: FontAwesomeIcons.solidFaceSadCry,
                helper: TextButton.icon(
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Refresh'),
                  onPressed: () {
                    dealsNotifier.reset(withLoading: true);
                  },
                ),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.all(6.0),
          sliver: SliverFixedExtentList.builder(
            itemExtent: cardHeight,
            itemCount: data.deals.length + 1,
            itemBuilder: (context, index) {
              if (index >= data.deals.length) {
                return LoadMore(
                  onPress: () => dealsNotifier.fetchMore(),
                  hasReachedMax: data.hasReachedMax,
                );
              }

              return DealCard(
                deal: data.deals[index],
                cardType: cardType,
                page: NavigationBranch.deals,
              );
            },
          ),
        );
      },
    );
  }
}
