import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deals/deals_list.dart';
import 'package:observatory/deals/deals_provider.dart';
import 'package:observatory/deals/deals_state.dart';
import 'package:observatory/deals/ui/deals_appbar.dart';
import 'package:observatory/deals/ui/deals_info_app_bar.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';

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

    return RefreshIndicator.adaptive(
      edgeOffset: AppBar().preferredSize.height +
          MediaQuery.of(context).viewPadding.top,
      onRefresh: () async {
        await ref.read(provider.notifier).reset();
      },
      child: CustomScrollView(
        controller: PrimaryScrollController.of(context),
        slivers: [
          const DealsAppBar(),
          DealsInfoAppBar(
            provider: provider,
          ),
          DealsList(
            provider: provider,
          ),
        ],
      ),
    );
  }
}
