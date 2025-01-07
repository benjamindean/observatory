import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:observatory/bookmarks/ui/bookmarks_info_bar.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/pull_to_refresh.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:observatory/shared/widgets/scroll_progress/scroll_progress.dart';
import 'package:observatory/shared/widgets/scroll_progress/scroll_progress_provider.dart';
import 'package:observatory/waitlist/ui/waitlist_appbar.dart';
import 'package:observatory/waitlist/waitlist_list.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class WaitListPage extends HookConsumerWidget {
  const WaitListPage({
    super.key,
  });

  void updateProgress(ScrollController controller, WidgetRef ref) {
    ref.read(scrollProgressProvider.notifier).state =
        controller.offset / controller.position.maxScrollExtent;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = useScrollController();
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

    useEffect(() {
      scrollController.addListener(() => updateProgress(scrollController, ref));

      return () => scrollController.removeListener(
            () => updateProgress(scrollController, ref),
          );
    }, [scrollController]);

    return PullToRefresh(
      onRefresh: () async {
        await ref.read(asyncWaitListProvider.notifier).reset();
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            key: const Key('waitlist-scroll-view'),
            controller: scrollController,
            slivers: [
              WaitlistAppBar(
                scrollController: scrollController,
              ),
              const HeaderLocator.sliver(),
              const SliverToBoxAdapter(
                child: BookmarksInfoBar(),
              ),
              const WaitListList(),
            ],
          ),
          ScrollProgress(),
        ],
      ),
    );
  }
}
