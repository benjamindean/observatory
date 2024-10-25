import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/library/providers/library_provider.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/bottom_sheet_container.dart';
import 'package:observatory/shared/ui/backdrop_container.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class AddedOn extends StatelessWidget {
  const AddedOn({
    super.key,
    required this.added,
  });

  final int added;

  @override
  Widget build(BuildContext context) {
    if (added == 0) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.access_time_filled_sharp,
            color: context.colors.scheme.secondary,
            size: context.textStyles.labelLarge.fontSize,
          ),
          const SizedBox(width: 4.0),
          Text.rich(
            TextSpan(
              style: context.themes.text.labelSmall?.copyWith(
                color: context.colors.hint,
              ),
              text: 'Added on ',
              children: [
                TextSpan(
                  text: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                    DateTime.fromMillisecondsSinceEpoch(
                      added.toInt(),
                    ),
                  ),
                  style: context.themes.text.labelSmall?.copyWith(
                    color: context.colors.hint,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InLibraryHint extends StatelessWidget {
  const InLibraryHint({
    super.key,
    required this.isInLibrary,
  });

  final bool isInLibrary;

  @override
  Widget build(BuildContext context) {
    if (!isInLibrary) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.library_add_check,
            color: context.colors.scheme.secondary,
            size: context.textStyles.labelLarge.fontSize,
          ),
          const SizedBox(width: 4.0),
          Text(
            'In Library',
            style: context.themes.text.labelSmall?.copyWith(
              color: context.colors.hint,
            ),
          )
        ],
      ),
    );
  }
}

class DealBottomSheet extends ConsumerWidget {
  final Deal deal;

  const DealBottomSheet({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> waitlist = ref.watch(waitlistIdsProvider);
    final bool isInWaitlist = waitlist.contains(deal.id);

    final List<String> bookmarks = ref.watch(bookmarkIdsProvider);
    final bool isInBookmarks = bookmarks.contains(deal.id);

    final List<String> library = ref.watch(libraryIdsProvider);
    final bool isInLibrary = library.contains(deal.id);

    return BottomSheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deal.titleParsed,
                  style: context.themes.text.titleMedium?.copyWith(
                    color: context.colors.scheme.onSurface,
                  ),
                ),
                AddedOn(
                  added: deal.added,
                ),
                InLibraryHint(
                  isInLibrary: isInLibrary,
                )
              ],
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
                ListTile(
                  leading: Icon(
                    isInBookmarks
                        ? Icons.push_pin_rounded
                        : Icons.push_pin_outlined,
                    color: context.colors.scheme.tertiary,
                  ),
                  title: Text(
                    !isInWaitlist
                        ? 'Add to Waitlist and Pin'
                        : (isInBookmarks ? 'Unpin' : 'Pin'),
                  ),
                  onTap: () {
                    if (!isInWaitlist) {
                      DealFunctions.addDealToWaitlist(
                        context: context,
                        ref: ref,
                        deal: deal,
                        showToast: false,
                      );
                    }

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
