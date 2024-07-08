import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deal/ui/deal_card.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/deals/state/deals_state.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/ui/constants.dart';
import 'package:observatory/shared/ui/ory_full_screen_spinner.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/load_more.dart';

class DealsList extends ConsumerWidget {
  final AutoDisposeFamilyAsyncNotifierProvider<AsyncDealsNotifier, DealsState,
      DealCategory> provider;

  const DealsList({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<DealsState> deals = ref.watch(provider);
    final AsyncDealsNotifier dealsNotifier = ref.watch(provider.notifier);
    final bool showHeaders = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.showHeaders ?? false,
      ),
    );
    final DealCardType cardType = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.dealCardType ?? DealCardType.compact,
      ),
    );
    final double? screenWidth = cardType == DealCardType.compact
        ? null
        : MediaQuery.of(context).size.width;
    final double height = cardHeight(showHeaders, cardType, screenWidth);

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
                onPressed: () async {
                  await dealsNotifier.reset(withLoading: true);
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
                  onPressed: () async {
                    await dealsNotifier.reset(
                      withLoading: true,
                    );
                  },
                ),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.all(6.0),
          sliver: SliverFixedExtentList.builder(
            itemExtent: height,
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
              );
            },
          ),
        );
      },
    );
  }
}
