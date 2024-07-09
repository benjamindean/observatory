import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/shared/models/deal.dart';

class BookmarkButton extends ConsumerWidget {
  final Deal deal;

  const BookmarkButton({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> bookmarks = ref.watch(bookmarkIdsProvider);
    final bool isInBookmarks = bookmarks.contains(deal.id);

    return Tooltip(
      message: isInBookmarks ? 'Remove from Bookmarks' : 'Add to Bookmarks',
      child: IconButton(
        icon: Icon(
          isInBookmarks
              ? Icons.bookmark_rounded
              : Icons.bookmark_border_rounded,
          color: context.colors.scheme.secondary,
        ),
        onPressed: () => onPressed(isInBookmarks, ref, context),
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
