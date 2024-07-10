import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/deal/providers/deal_card_size_provider.dart';
import 'package:observatory/deal/ui/deal_card_compact.dart';
import 'package:observatory/router.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/constants.dart';
import 'package:observatory/shared/ui/observatory_back_button.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

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
      appBar: AppBar(
        titleSpacing: 0.0,
        title: ListTile(
          title: Text(
            'Pinned Games',
            maxLines: 1,
            style: TextStyle(
              fontSize: context.themes.text.titleMedium?.fontSize,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: const Text("Games you've pinned for later"),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: APPBAR_ELEVATION,
        surfaceTintColor: context.colors.scheme.surfaceTint,
        child: Row(
          children: <Widget>[
            const Expanded(
              // flex: 50,
              child: ObservatoryBackButton(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Tooltip(
                message: 'Remove All',
                child: FilledButton.icon(
                  onPressed: () => ref
                      .read(asyncBookmarksProvider.notifier)
                      .clearBookmarks(),
                  label: const Text('Remove All'),
                  icon: Icon(
                    Icons.cancel_rounded,
                    color: context.colors.scheme.primaryContainer,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: waitlist.when(
          loading: () => const ObservatoryProgressIndicator(),
          error: (error, stackTrace) {
            Logger().e(
              'Failed to load bookmarks',
              error: error,
              stackTrace: stackTrace,
            );

            FirebaseCrashlytics.instance.recordError(
              error,
              stackTrace,
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
              return const Center(
                child: ErrorMessage(
                  message: 'You have no bookmarks.',
                  icon: FontAwesomeIcons.solidFaceSadTear,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView.builder(
                itemExtent: cardHeight,
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  return DealCardCompact(
                    deal: bookmarks[index],
                    page: NavigationBranch.waitlist,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
