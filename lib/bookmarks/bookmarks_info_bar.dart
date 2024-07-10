import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/shared/context_extension.dart';
import 'package:observatory/shared/models/deal.dart';

class BookmarksInfoBar extends ConsumerWidget {
  const BookmarksInfoBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Deal>> bookmarks = ref.watch(asyncBookmarksProvider);
    final bool collapsePinned = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.collapsePinned ?? false,
      ),
    );

    if (!collapsePinned) {
      return const SizedBox.shrink();
    }

    return bookmarks.when(
      data: (deals) {
        if (deals.isEmpty) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () => context.push('/bookmarks'),
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
                  Icons.push_pin,
                  color: context.colors.scheme.onSurfaceVariant,
                ),
                title: Text(
                  '${deals.length} Pinned ${Intl.plural(
                    deals.length,
                    one: 'Game',
                    other: 'Games',
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
