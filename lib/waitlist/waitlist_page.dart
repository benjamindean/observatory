import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:observatory/bookmarks/ui/bookmarks_info_bar.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/pull_to_refresh.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:observatory/waitlist/ui/waitlist_appbar.dart';
import 'package:observatory/waitlist/waitlist_list.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class WaitListPage extends ConsumerWidget {
  const WaitListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Deal>? deals = ref.watch(
      asyncWaitListProvider.select(
        (value) => value.valueOrNull ?? [],
      ),
    );

    if (deals == null) {
      return const Center(
        child: ObservatoryProgressIndicator(),
      );
    }

    return PullToRefresh(
      onRefresh: () async {
        await ref.read(asyncWaitListProvider.notifier).reset();
      },
      child: CustomScrollView(
        key: const Key('waitlist-scroll-view'),
        controller: PrimaryScrollController.of(context),
        slivers: const [
          WaitlistAppBar(),
          HeaderLocator.sliver(),
          SliverToBoxAdapter(
            child: BookmarksInfoBar(),
          ),
          WaitListList(),
        ],
      ),
    );
  }
}
