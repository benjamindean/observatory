import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:observatory/bookmarks/bookmarks_page.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/shared/context_extension.dart';
import 'package:observatory/shared/models/deal.dart';

class BookmarksInfoBar extends ConsumerWidget {
  const BookmarksInfoBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Deal>> bookmarks = ref.watch(asyncBookmarksProvider);

    return bookmarks.when(
      data: (deals) {
        if (deals.isEmpty) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () => showBookmarks(context),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.elevatedBottomAppBarColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
                leading: Icon(
                  Icons.bookmark,
                  color: context.colors.scheme.onSurfaceVariant,
                ),
                title: Text(
                  '${deals.length} ${Intl.plural(
                    deals.length,
                    one: 'Bookmark',
                    other: 'Bookmarks',
                  )}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.labelLarge.copyWith(
                    color: context.colors.scheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  deals.map((deal) => deal.titleParsed).join(', '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.labelSmall.copyWith(
                    color: context.colors.hint,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      loading: () {
        return const SizedBox.shrink();
      },
      error: (error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }
}
