import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:observatory/auth/providers/itad_provider.dart';
import 'package:observatory/deal/providers/deal_card_size_provider.dart';
import 'package:observatory/deal/ui/deal_card.dart';
import 'package:observatory/router.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/auth/providers/steam_provider.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/ory_full_screen_spinner.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/waitlist/ui/empty_waitlist.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

class WaitListList extends ConsumerWidget {
  const WaitListList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Deal>> waitlist = ref.watch(asyncWaitListProvider);
    final List<Deal> filteredWaitlist = ref.watch(filteredWaitlistProvider);

    final bool isSearchActive = ref.watch(
      waitlistSearchProvider.select(
        (value) => value.isOpen && value.query != null,
      ),
    );
    final bool isSteamImportLoading = ref.watch(
      steamProvider.select(
        (value) => value.isLoading,
      ),
    );
    final bool isITADImportLoading = ref.watch(
      itadProvider.select(
        (value) => value.isLoading,
      ),
    );
    final double cardHeight = ref
        .watch(dealCardSizeProvider.notifier)
        .getHeight(MediaQuery.of(context).size.width);

    if (isSteamImportLoading || isITADImportLoading) {
      return OryFullScreenSpinner(
        message: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'Importing your waitlist\nThis might take a while depending on the size of your waitlist',
            textAlign: TextAlign.center,
            style: context.textStyles.labelLarge.copyWith(
              color: context.colors.scheme.onSurfaceVariant,
            ),
          ),
        ),
      );
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

        Sentry.captureException(
          error,
          stackTrace: stackTrace,
        );

        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: ErrorMessage(
              icon: FontAwesomeIcons.solidFaceDizzy,
              message: 'Failed to fetch waitlist.',
              helper: TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
                onPressed: () {
                  ref
                      .watch(asyncWaitListProvider.notifier)
                      .reset(withLoading: true);
                },
              ),
            ),
          ),
        );
      },
      data: (deals) {
        if (isSearchActive && filteredWaitlist.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorMessage(
              message: 'No games found for your query.',
              icon: FontAwesomeIcons.solidFaceSadTear,
            ),
          );
        }

        if (filteredWaitlist.isEmpty && deals.isNotEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorMessage(
              message: 'All of your waitlisted games are pinned.',
              icon: Icons.push_pin_rounded,
            ),
          );
        }

        if (filteredWaitlist.isEmpty) {
          return const EmptyWaitlist();
        }

        return SliverPadding(
          padding: const EdgeInsets.all(6.0),
          sliver: SliverFixedExtentList.builder(
            itemExtent: cardHeight,
            itemBuilder: (context, index) {
              return DealCard(
                deal: filteredWaitlist[index],
                page: NavigationBranch.waitlist,
              );
            },
            itemCount: filteredWaitlist.length,
          ),
        );
      },
    );
  }
}
