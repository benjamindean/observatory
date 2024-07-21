import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/router.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/bottom_sheet_container.dart';
import 'package:observatory/shared/ui/backdrop_container.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class DealBottomSheet extends ConsumerWidget {
  final Deal deal;
  final NavigationBranch page;

  const DealBottomSheet({
    super.key,
    required this.deal,
    required this.page,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isWaitlistPage = page == NavigationBranch.waitlist;

    final List<String> waitlist = ref.watch(waitlistIdsProvider);
    final bool isInWaitlist = waitlist.contains(deal.id);

    final List<String> bookmarks = ref.watch(bookmarkIdsProvider);
    final bool isInBookmarks = bookmarks.contains(deal.id);

    return BottomSheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              deal.titleParsed,
              style: context.themes.text.titleMedium?.copyWith(
                color: context.colors.scheme.onSurface,
              ),
            ),
          ),
          BackdropContainer(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    isInWaitlist ? Icons.favorite : Icons.favorite_border,
                    color: context.colors.primary,
                  ),
                  title: Text(
                    isInWaitlist ? 'Remove from Waitlist' : 'Add to Waitlist',
                  ),
                  onTap: () {
                    if (isInWaitlist) {
                      return DealFunctions.removeDealFromWaitlist(
                        context: context,
                        ref: ref,
                        deal: deal,
                        showToast: false,
                      );
                    }

                    return DealFunctions.addDealToWaitlist(
                      context: context,
                      ref: ref,
                      deal: deal,
                      showToast: false,
                    );
                  },
                ),
                if (isWaitlistPage)
                  ListTile(
                    leading: Icon(
                      isInBookmarks
                          ? Icons.push_pin_rounded
                          : Icons.push_pin_outlined,
                      color: context.colors.scheme.tertiary,
                    ),
                    title: Text(
                      isInBookmarks ? 'Unpin' : 'Pin',
                    ),
                    onTap: () {
                      if (isInBookmarks) {
                        return DealFunctions.removeBookmark(
                          context: context,
                          ref: ref,
                          deal: deal,
                          showToast: false,
                        );
                      }

                      return DealFunctions.addBookmark(
                        context: context,
                        ref: ref,
                        deal: deal,
                        showToast: false,
                      );
                    },
                  ),
                ListTile(
                  leading: Icon(
                    Icons.open_in_browser,
                    color: context.colors.scheme.secondary,
                  ),
                  title: const Text('Open in Browser'),
                  onTap: deal.prices?.firstOrNull != null
                      ? () {
                          DealFunctions.openDealLink(deal);
                          context.pop();
                        }
                      : null,
                ),
                ListTile(
                  leading: Icon(
                    Icons.share,
                    color: context.colors.scheme.tertiary,
                  ),
                  title: const Text('Share Link'),
                  onTap: deal.prices?.firstOrNull != null
                      ? () {
                          DealFunctions.shareDeal(deal);

                          context.pop();
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
