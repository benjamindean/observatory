import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class BookmarkButton extends ConsumerWidget {
  final Deal deal;

  const BookmarkButton({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> waitlist = ref.watch(waitlistIdsProvider);
    final bool isInWaitlist = waitlist.contains(deal.id);

    final List<String> bookmarks = ref.watch(bookmarkIdsProvider);
    final bool isInBookmarks = bookmarks.contains(deal.id);

    return Tooltip(
      message: isInBookmarks ? 'Unpin' : 'Pin',
      child: IconButton(
        icon: Icon(
          isInBookmarks ? Icons.push_pin_rounded : Icons.push_pin_outlined,
          color: isInWaitlist
              ? context.colors.scheme.secondary
              : context.colors.disabled,
        ),
        onPressed:
            isInWaitlist ? () => onPressed(isInBookmarks, ref, context) : null,
      ),
    );
  }

  Future<void> onPressed(
    bool isInBookmarks,
    WidgetRef ref,
    BuildContext context,
  ) async {
    if (isInBookmarks) {
      return DealFunctions.removeBookmark(
        context: context,
        ref: ref,
        deal: deal,
      );
    }

    return DealFunctions.addBookmark(
      context: context,
      ref: ref,
      deal: deal,
    );
  }
}
