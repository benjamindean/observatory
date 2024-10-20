import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deals/deals_list.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/deals/ui/deals_appbar.dart';
import 'package:observatory/deals/ui/itad_filters_info_bar.dart';
import 'package:observatory/shared/ui/pull_to_refresh.dart';

class DealsPage extends ConsumerWidget {
  const DealsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PullToRefresh(
      onRefresh: () async {
        await ref.read(asyncDealsProvider.notifier).reset();
      },
      child: CustomScrollView(
        key: const Key('deals-scroll-view'),
        controller: PrimaryScrollController.of(context),
        slivers: [
          const DealsAppBar(),
          const HeaderLocator.sliver(),
          SliverToBoxAdapter(
            child: ITADFiltersInfoBar(),
          ),
          const DealsList(),
        ],
      ),
    );
  }
}
