import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deals/deals_list.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/deals/state/deals_state.dart';
import 'package:observatory/deals/ui/deals_appbar.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/ui/pull_to_refresh.dart';

class DealsPage extends ConsumerWidget {
  const DealsPage({super.key});

  AutoDisposeFamilyAsyncNotifierProvider<AsyncDealsNotifier, DealsState,
      DealCategory> getProvider(DealCategory category) {
    return asyncDealsProvider(category);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DealCategory activeTab = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.value?.dealsTab ?? DealCategory.steam_top_sellers,
      ),
    );
    final provider = getProvider(activeTab);

    return PullToRefresh(
      onRefresh: () async {
        await ref.read(provider.notifier).reset();
      },
      child: CustomScrollView(
        key: const Key('deals-scroll-view'),
        controller: PrimaryScrollController.of(context),
        slivers: [
          const DealsAppBar(),
          const HeaderLocator.sliver(),
          DealsList(
            provider: provider,
          ),
        ],
      ),
    );
  }
}
