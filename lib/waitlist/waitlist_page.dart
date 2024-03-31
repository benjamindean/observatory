import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/waitlist/ui/waitlist_appbar.dart';
import 'package:observatory/waitlist/ui/waitlist_info_app_bar.dart';
import 'package:observatory/waitlist/waitlist_list.dart';
import 'package:observatory/waitlist/waitlist_provider.dart';

class WaitListPage extends ConsumerWidget {
  const WaitListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator.adaptive(
      edgeOffset: AppBar().preferredSize.height +
          MediaQuery.of(context).viewPadding.top,
      onRefresh: () async {
        await ref.read(asyncWaitListProvider.notifier).reset();
      },
      child: CustomScrollView(
        controller: PrimaryScrollController.of(context),
        slivers: const [
          WaitlistAppBar(),
          WaitlistInfoAppBar(),
          WaitListList(),
        ],
      ),
    );
  }
}
