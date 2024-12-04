import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/deal/providers/deal_card_size_provider.dart';
import 'package:observatory/deal/ui/deal_card.dart';
import 'package:observatory/router.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/observatory_back_button.dart';
import 'package:observatory/shared/ui/observatory_dialog.dart';
import 'package:observatory/shared/ui/ory_full_screen_spinner.dart';
import 'package:observatory/shared/ui/pull_to_refresh.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Deal>> waitlist = ref.watch(asyncWaitListProvider);
    final List<String> bookmarksIds = ref.watch(bookmarkIdsProvider);

    final double cardHeight = ref
        .watch(dealCardSizeProvider.notifier)
        .getHeight(MediaQuery.of(context).size.width);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 40,
              child: ObservatoryBackButton(),
            ),
            Expanded(
              flex: 20,
              child: SizedBox.expand(),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return ObservatoryDialog(
                      onApply: () {
                        ref
                            .read(asyncBookmarksProvider.notifier)
                            .clearBookmarks()
                            .then(
                          (value) {
                            if (context.mounted) {
                              context.pop();
                            }
                          },
                        );
                      },
                      onDiscard: () {
                        context.pop();
                      },
                      title: 'Remove all pinned games?',
                      body: 'This operation cannot be undone.',
                      discardText: 'Cancel',
                      applyText: 'Remove',
                    );
                  },
                );
              },
              child: const Text('Remove All'),
            )
          ],
        ),
      ),
      body: PullToRefresh(
        onRefresh: () async {
          await ref.read(asyncWaitListProvider.notifier).reset();
        },
        child: CustomScrollView(
          key: const Key('waitlist-scroll-view'),
          controller: PrimaryScrollController.of(context),
          slivers: [
            SliverAppBar(
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Pinned Games'),
              ),
            ),
            HeaderLocator.sliver(),
            waitlist.when(
              loading: () => const OryFullScreenSpinner(),
              error: (error, stackTrace) {
                Logger().e(
                  'Failed to load bookmarks',
                  error: error,
                  stackTrace: stackTrace,
                );

                Sentry.captureException(
                  error,
                  stackTrace: stackTrace,
                );

                return const ErrorMessage(
                  icon: FontAwesomeIcons.solidFaceFrown,
                  message: 'Failed to load pinned games.',
                );
              },
              data: (deals) {
                final List<Deal> bookmarks = deals.where((deal) {
                  return bookmarksIds.contains(deal.id);
                }).toList();

                if (bookmarks.isEmpty) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: ErrorMessage(
                        message: 'You have no bookmarks.',
                        icon: FontAwesomeIcons.solidFaceSadTear,
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(6.0),
                  sliver: SliverFixedExtentList.builder(
                    itemExtent: cardHeight,
                    itemCount: bookmarks.length,
                    itemBuilder: (context, index) {
                      return DealCard(
                        deal: bookmarks[index],
                        page: NavigationBranch.waitlist,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
