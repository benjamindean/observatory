import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/pull_to_refresh.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:observatory/waitlist/ui/waitlist_appbar.dart';
import 'package:observatory/waitlist/ui/waitlist_info_app_bar.dart';
import 'package:observatory/waitlist/waitlist_list.dart';
import 'package:observatory/waitlist/waitlist_provider.dart';

class WaitListPage extends ConsumerWidget {
  const WaitListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Deal>? deals = ref.watch(asyncWaitListProvider.select(
      (value) => value.valueOrNull?.deals,
    ));

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
        slivers: [
          const WaitlistAppBar(),
          const HeaderLocator.sliver(),
          if (deals.isNotEmpty) const WaitlistInfoAppBar(),
          const WaitListList(),
        ],
      ),
    );
  }
}
