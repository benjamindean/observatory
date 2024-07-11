import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/deal/providers/deal_card_size_provider.dart';
import 'package:observatory/deal/ui/deal_card_compact.dart';
import 'package:observatory/router.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/constants.dart';
import 'package:observatory/shared/ui/observatory_back_button.dart';
import 'package:observatory/shared/ui/observatory_dialog.dart';
import 'package:observatory/shared/ui/ory_full_screen_spinner.dart';
import 'package:observatory/shared/widgets/error_message.dart';
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
      bottomNavigationBar: BottomAppBar(
        elevation: APPBAR_ELEVATION,
        surfaceTintColor: context.colors.scheme.surfaceTint,
        child: Row(
          children: <Widget>[
            const Expanded(
              child: ObservatoryBackButton(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Tooltip(
                message: 'Remove All',
                child: FilledButton.icon(
                  onPressed: bookmarksIds.isEmpty
                      ? null
                      : () {
                          showAdaptiveDialog(
                            context: context,
                            builder: (context) {
                              return ObservatoryDialog(
                                onApply: () async {
                                  ref
                                      .read(asyncBookmarksProvider.notifier)
                                      .clearBookmarks()
                                      .then(context.pop);
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
                  label: const Text('Remove All'),
                  icon: const Icon(
                    Icons.cancel_rounded,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        key: const Key('waitlist-scroll-view'),
        controller: PrimaryScrollController.of(context),
        slivers: [
          SliverAppBar(
            surfaceTintColor: context.colors.scheme.surfaceTint,
            floating: true,
            flexibleSpace: AppBar(
              title: Text(
                'Pinned Games',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
            ),
          ),
          waitlist.when(
            loading: () => const OryFullScreenSpinner(),
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
                    return DealCardCompact(
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
    );
  }
}
