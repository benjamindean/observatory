import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deal/ui/deal_card.dart';
import 'package:observatory/deals/deals_provider.dart';
import 'package:observatory/deals/deals_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/load_more.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

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

    return deals.when(
      loading: () {
        return const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: ObservatoryProgressIndicator(),
          ),
        );
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
              message:
                  'Failed to fetch deals. IsThereAnyDeal API might be down at the moment.',
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
                message: 'No deals for now',
                icon: Icons.info,
                helper: TextButton(
                  child: const Text('Refresh'),
                  onPressed: () async {
                    await dealsNotifier.reset();
                  },
                ),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.all(6.0),
          sliver: SliverList.builder(
            itemCount:
                data.hasReachedMax ? data.deals.length : data.deals.length + 1,
            itemBuilder: (context, index) {
              if (index >= data.deals.length) {
                if (data.hasReachedMax) {
                  return const SizedBox.shrink();
                }

                return LoadMore(
                  onPress: () => dealsNotifier.fetchMore(),
                );
              }

              return DealCard(
                deal: data.deals[index],
              );
            },
          ),
        );
      },
    );
  }
}
